import fs from 'fs';

import * as Model from "./model"
import * as VESCreader from "./vesc"
import * as Hardware from "./hardware"
import * as BatteryReader from './batteryReader';
import { Packet } from 'vesc-ble';
import { FileHandle } from 'fs/promises';


export enum State { Booting = 0, Idle = 1, Armed = 2, Charging = 3, Balancing = 4, Active = 5, Error = 6 }

class BoatModelAttribute extends Model.ModelAttribute
{
	model: BoatModel

	constructor( model: BoatModel )
	{
		super()
		this.model = model
	}
}
export class MJoulnirState extends BoatModelAttribute
{
	public state: State;

	constructor(model: BoatModel)
	{
		super(model);

		this.state = State.Booting
	}
	
	toString(): string
	{
		return State[ this.state ];
	}

	set( newState: State ): void
	{
		if( newState != this.state )
		{
			console.log( "MJoulnirState changed to " + newState );
			this.state = newState
			this.signalUpdated()
		}
	}
}

export class ChargerState extends BoatModelAttribute
{
	public static readonly efficiency = 0.9;

	public detected = false;
	public output_voltage?: number;
	public output_current?: number;
	public hardware_good?: boolean;
	public temperature_good?: boolean;
	public input_voltage_good?: boolean;
	public battery_detect_good?: boolean;
	public communication_good?: boolean;

	public max_voltage?: number;
	public max_current?: number;
	public do_charge?: boolean;
	public total_charge_J = 0;

	update1( output_voltage: number, output_current: number, 
		hardware_good: boolean, 
		temperature_good: boolean, 
		input_voltage_good: boolean,
		battery_detect_good: boolean, 
		communication_good: boolean, add_charge_J: number ): void
	{
		let changed = false;

		if( !this.detected )
		{
			this.detected = true;
			changed = true;
		}

		if( add_charge_J != 0 )
		{
			this.total_charge_J += add_charge_J;
			changed = true;
		}

		if( output_voltage != this.output_voltage )
		{
			this.output_voltage = output_voltage;
			changed = true;
		}

		if( output_current != this.output_current )
		{
			this.output_current = output_current;
			changed = true;
		}

		if( hardware_good != this.hardware_good )
		{
			this.hardware_good = hardware_good;
			changed = true;
		}

		if( temperature_good != this.temperature_good )
		{
			this.temperature_good = temperature_good;
			changed = true;
		}

		if( input_voltage_good != this.input_voltage_good )
		{
			this.input_voltage_good = input_voltage_good;
			changed = true;
		}

		if( battery_detect_good != this.battery_detect_good )
		{
			this.battery_detect_good = battery_detect_good;
			changed = true;
		}

		if( communication_good != this.communication_good )
		{
			this.communication_good = communication_good;
			changed = true;
		}

		if( changed )
			this.signalUpdated();

		this.model.battery.updateEstimatedCurrent()
	}

	public updateCharging( max_voltage: number, max_current: number, do_charge: boolean )
	{
		let changed = false;
	
		if( max_voltage != this.max_voltage )
		{
			this.max_voltage = max_voltage;
			changed = true;
		}

		if( max_current != this.max_current)
		{
			this.max_current = max_current;
			changed = true;
		}

		if( do_charge != this.do_charge )
		{
			this.do_charge = do_charge;
			changed = true;
		}

		if( changed )
			this.signalUpdated();
	}

	lostConnection(): void
	{
		if( !this.detected )
			return;

		this.detected = false;
		this.output_voltage = undefined;
		this.output_current = undefined;
		this.hardware_good = undefined;
		this.temperature_good = undefined;
		this.input_voltage_good = undefined;
		this.battery_detect_good = undefined;
		this.communication_good = undefined;

		this.signalUpdated();
	}

	canCharge(): boolean
	{
		const result = this.detected && this.hardware_good! && this.temperature_good! && 
			this.input_voltage_good! && this.battery_detect_good! && 
			this.communication_good!;

		// console.log( this.toString() )
		/*
		console.log( this.detected + ", hw:"  + this.hardware_good! + ", t:"  + 
			this.temperature_good! + ", iv:"  +  
			this.input_voltage_good! + ", bd:"  + this.battery_detect_good! + ", cg:"  + 
			this.communication_good!)
		console.log( "canCharge=" + result )
		*/
		return result
	}

	currentChargingPower(): number
	{
		if( !this.detected )
			return 0;
		else
			return this.output_voltage! * this.output_current!;
	}

	estimateCurrent(): number
	{
		if( this.output_current === undefined )
			return 0;
		else
			return this.output_current
	}

	toString(): string
	{
		let result: string;

		if( !this.detected )
			return "not detected";

		const power = this.output_voltage! * this.output_current!;

		result = "output power: " + power.toFixed(0) + " W (" + this.output_voltage!.toFixed(1) + 
			" V, " + this.output_current!.toFixed(1) + " A)";
		if( this.max_voltage )
			result += ", max voltage: " + this.max_voltage!.toFixed(1) + " V"
		if( this.max_current )
            result += ", max current: " + this.max_current!.toFixed(1) + " A"

		if( !(this.total_charge_J === undefined) )
			result += ", total charge=" + (this.total_charge_J / 1000).toFixed(0) + " kJ = " + 
				(this.total_charge_J / 3600).toFixed(0) + " Wh"
		if( !(this.do_charge === undefined) )
			result += ", charge: " + this.do_charge

		if( !this.hardware_good )
			result += ", hardware fault";

		if( !this.temperature_good )
			result += ", over temperature";

		if( !this.input_voltage_good )
			result += ", input voltage bad";

		if( !this.battery_detect_good )
			result += ", battery not detected";

		if( !this.communication_good )
			result += ", communication timeout";

		
		return result;
	}
}

export class Battery extends BoatModelAttribute
{
	static readonly LOG_FILE = "/var/log/mjoulnir/battery.log"
	static readonly BALANCE_MAX_DIFF_VOLTS = 0.0016; // 1.6 mV. Consider imbalanced if diff is more than this
	static readonly BALANCE_THRESHOLD_V = 0.0008; // drain any cells that exceed minimum by more than this
	static readonly FULL_ENERGY = 3 * 5300 * 3600; // 3 modules @ 5.3 kWh * 3600 seconds/hour = 57.24 MJ
	static readonly DEFAULT_POLLING_INTERVAL = 60
	static readonly soc_estimate_breakpoints = [ [0, 3.05], [0.04, 3.29], [0.12, 3.34], [0.26, 3.54], [0.53, 3.68], [0.63, 3.79], [0.98, 4.10], [1.0, 4.18]];

	public static estimateSOCfromCellVoltage( voltage: number ): number
	{
		const breakpoints = Battery.soc_estimate_breakpoints;
		let upperBreakpointIndex = breakpoints.length - 1;

		if( voltage < breakpoints[0][1] )
			return 0.0;

		if( voltage >= breakpoints[breakpoints.length-1][1])
			return 1.0;

		for( let i = 0; i < Battery.soc_estimate_breakpoints.length; i++ )
			if( breakpoints[i][1] > voltage )
			{
				upperBreakpointIndex = i;
				break;
			}

		// linear interpolation
		const lowerBreakpointIndex = upperBreakpointIndex - 1;
		const lowerBreakpoint = breakpoints[ lowerBreakpointIndex ];
		const upperBreakpoint = breakpoints[ upperBreakpointIndex ];

		return lowerBreakpoint[0] + 
			(voltage - lowerBreakpoint[1]) * 
			(upperBreakpoint[0] - lowerBreakpoint[0]) / 
			(upperBreakpoint[1] - lowerBreakpoint[1]);
	}

	public static estimateCellVoltageFromSOC( soc: number ): number
	{
		if( soc <= 0 )
			return 3.05; // never go below 3V
		if( soc >= 1.0 )
			return 4.18;

		// Initial version, using data from https://www.youtube.com/watch?v=HIAIX3oEHZs&t=2787s
		// Later calculate my own.
		// 
		// breakpoints: soc   0% = 3.05 V
		//              soc   4% = 3.29 V
		//              soc  12% = 3.34 V
		//              soc  26% = 3.54 V
		//		soc  53% = 3.68 V
		// 		soc  63% = 3.79 V
		//              soc  98% = 4.10 V
		//              soc 100% = 4.18 V
		let upperBreakpointIndex = Battery.soc_estimate_breakpoints.length - 1;

		for( let i = 0; i < Battery.soc_estimate_breakpoints.length; i++ )
			if( Battery.soc_estimate_breakpoints[i][0] > soc )
			{
				upperBreakpointIndex = i;
				break;
			}

		// linear interpolation
		const lowerBreakpointIndex = upperBreakpointIndex - 1;
		const lowerBreakpoint = Battery.soc_estimate_breakpoints[ lowerBreakpointIndex ];
		const upperBreakpoint = Battery.soc_estimate_breakpoints[ upperBreakpointIndex ];

		const result = lowerBreakpoint[1] + (soc - lowerBreakpoint[0]) * (upperBreakpoint[1] - lowerBreakpoint[1]) / (upperBreakpoint[0] - lowerBreakpoint[0]);

		return result;
	}

	private static sumForCells( values: number[][] )
	{
		let sum = values.reduce((acc, moduleValues): number => {
			const moduleTotal: number = moduleValues.reduce(
				(acc2: number, value: number) => acc2 + value, 0);

			return acc + moduleTotal;
		}, 0);
		
		return sum;
	}


	readonly batteryReader: BatteryReader.BatteryReader;

	public voltages: number[][] = [];
	public idleVoltages?: number[][]
	public currentCompensatedVoltages?: number[][];
	public temperatures: number[][] = [];
	// default resistances, TODO: read latest estimated resistances from disk.
	public resistances = [ 
		[ 0.064, 0.072, 0.069, 0.072, 0.069, 0.064 ],
		[ 0.068, 0.075, 0.070, 0.075, 0.070, 0.066 ],
		[ 0.062, 0.075, 0.071, 0.076, 0.070, 0.065 ] ];
	public balancingCells = []
	public is_balancing = false
	public totalInnerResistance = Battery.sumForCells(this.resistances);
	public fault = false;
	public alert = false;
	// imbalance is the difference between the max and min cell voltages when the battery is idle
	public imbalance_V?: number
	public imbalance_soc?: number
	// set by other parts of the system, used by battery state to update battery SOC
	// positive values for charging, negative for drain
	current = -0.101; // running raspberry pi with other hardware off consumes about 101 mA
	lastCurrentSetTime = Date.now() / 1000.0
	initial_energy_estimate_from_voltage?: number
	estimated_energy_change = 0
	estimated_energy_from_voltage?: number  // in Joules
	estimated_energy_from_consumption?: number
	
	log_file?: fs.promises.FileHandle
	log_is_opening = false
	log_is_writing = false
	
	constructor(model: BoatModel, batteryReaderSerialPortName: string)
	{
		super(model);

		this.batteryReader = new BatteryReader.BatteryReader( batteryReaderSerialPortName );
		this.batteryReader.on( 'update', (data) => this.updateModelFromBMS(data) )
	}
	
	/* 
	 * Functions on the BatteryReader 
	 */
	async start(): Promise<void>
	{
		// todo: monitor fault line from battery
		return this.batteryReader.start(Battery.DEFAULT_POLLING_INTERVAL)
	}

	async poll( updateImbalances: boolean ): Promise<void>
	{
		return this.batteryReader.poll(updateImbalances)
	}

	setPollingInterval( interval: number ): void
	{
		this.batteryReader.setInterval( interval )
	}

	public async balance_cells( safety_timer: number, cells_to_balance: boolean[][] ): Promise<void>
	{
		return this.batteryReader.setBalanceTimer( safety_timer )
		.then( () => this.batteryReader.balance( cells_to_balance ) )
		.then( () => { this.is_balancing = true; } )
	}

	public async stopBalancing(): Promise<void>
	{
		return this.batteryReader.stopBalancing()
			.then( () => { this.is_balancing = false } )
	}

	updateModelFromBMS(data: BatteryReader.UpdateData): void
	{
		this.voltages = data.voltages
		this.temperatures = data.temperatures
		this.fault = data.fault
		this.alert = data.alert
		this.isValid = true
		if( data.update_imbalance )
			this.updateImbalance()
		this.signalUpdated()
	}
	// attributes
	// 18 elements - voltages in each cell
	// minCellVoltage
	
	// parameter: array of 3 arrays with 6 voltages
	setVoltages(voltages: number[][]): void
	{
		this.voltages = voltages;
		if( this.current < 0.5 )
		{
			this.idleVoltages = []
			for( let module = 0; module < this.voltages.length; module++ )
			{
				this.idleVoltages[module] = []
			
				for( let cellGroup = 0; cellGroup < this.voltages[ module ].length; cellGroup++ )
					this.idleVoltages[module][cellGroup] = voltages[module][cellGroup] + this.current * this.resistances[module][cellGroup];
			}

			let packIdleVoltage = Battery.sumForCells( this.idleVoltages);
			console.log( "idleVoltage estimated to " + packIdleVoltage + " (cell average: " + (packIdleVoltage / 18).toFixed(3) + ")" )

			this.estimated_energy_from_voltage = Battery.estimateSOCfromCellVoltage( packIdleVoltage / 18 ) * Battery.FULL_ENERGY;

			if( this.initial_energy_estimate_from_voltage === undefined )
			{
				this.initial_energy_estimate_from_voltage = this.estimated_energy_from_voltage
				console.log( "Initial energy estimate: " + this.initial_energy_estimate_from_voltage )
			}
		}

		this.writeLog()
	}


	setCurrent( current: number ): void
	{
		const now = Date.now() / 1000.0;
		const dt = now - this.lastCurrentSetTime
		const interpolated_current = (current + this.current) / 2

		this.current = current;
		this.lastCurrentSetTime = now;

		// update energy
		const batteryEnergyLoss = interpolated_current * interpolated_current * this.totalInnerResistance * dt
		const totalVoltage = this.getTotalVoltage()
		if( totalVoltage !== undefined )
		{
			const addedEnergy = interpolated_current * totalVoltage! * dt

			this.estimated_energy_change += (addedEnergy - batteryEnergyLoss)

			this.writeLog()
		}
	}

	estimateResistances( current: number, idleVoltages: number[][], currentVoltages: number[][] )
	{
		const resistances: number[][] = []
		
		let text = "Resistances (mΩ): ";
		/// one module is 444 cells, divided into 6 groups in series -> 74 cells in parallell
		// current is divided among these 
		const currentPerCell = current / 74;

		console.log( "Current: " + current + " A, idleVoltages=" + idleVoltages + ", currentVoltages = " + currentVoltages + 
			", currentPerCell=" + currentPerCell )

		for( let module_index = 0; 
             module_index < idleVoltages.length;
             module_index++ )
		{
			resistances[ module_index ] = []
			text += " Module " + module_index + ": [";

			for( let cell_index = 0; 
                 cell_index < idleVoltages[module_index].length;
                 cell_index++ )
			{
				const dV = currentVoltages[ module_index ][ cell_index ]
					- idleVoltages[ module_index ][ cell_index ];

				const resistance = dV / currentPerCell;
				// if( (module_index == 0) && (cell_index == 0) )
				//	console.log( "dV[0][0]=" + dV )
				resistances[ module_index ][ cell_index ] = resistance;
				if( cell_index != 0 )
					text += ", "
				text += (resistance * 1000).toFixed(0);
			}
			text += " ]\n";
		}

		// this.model.batteryState.setResistances( resistances );
		console.log( text );

		this.resistances = resistances
		this.totalInnerResistance = Battery.sumForCells(resistances);
		console.log( "Set total R=" + this.totalInnerResistance + ", resistances to " + resistances )
		// this.setResistances( resistances );
		this.signalUpdated()

		// this.battery.resistances = resistances;
		// this.battery.signalUpdated();
	}

	updateEstimatedCurrent()
	{
		const hardwareCurrent = this.model.hardware.estimateCurrent()
		const chargerCurrent = this.model.charger.estimateCurrent()
		const vescCurrent = this.model.vescState.estimateCurrent()

		const newCurrent = hardwareCurrent + chargerCurrent + vescCurrent
/*
		console.log( "Estimated Current: " + newCurrent.toFixed(3) + " = " + 
			hardwareCurrent.toFixed(3) + " + " + 
			chargerCurrent.toFixed(3) + " + " +
			vescCurrent )
*/
		this.setCurrent( newCurrent );
	}

	
	// parameter: array of (6) temperaetures
	setTemperatures(temperatures: number[][]): void
	{
		this.temperatures = temperatures;
	}

	getModuleCount(): number | undefined
	{
		return this.voltages?.length;
	}
	
	getModuleVoltage(moduleNumber: number): number | undefined
	{
		const moduleVoltages = this.voltages?[moduleNumber] : undefined;
		
		return moduleVoltages?.reduce( (acc, voltage) => acc + voltage, 0 );
	}

	getTotalVoltage(): number | undefined {

		return Battery.sumForCells( this.voltages! )
	}

	getMinCellVoltage(): number | undefined
	{
		let voltage: number | undefined = undefined;

		voltage = this.voltages?.reduce( (acc, moduleVoltages): number =>
			Math.min( acc, ...moduleVoltages )
			, 100 );

		return voltage;
	}

	getMaxCellVoltage(): number | undefined
	{
		let voltage: number | undefined = undefined;

		voltage = this.voltages?.reduce( (acc, moduleVoltages): number =>
			Math.max( acc, ...moduleVoltages )
			, 0 );

		return voltage;
	}

	getMinTemperature(): number | undefined {
		let temperature: number | undefined = undefined;

		temperature = this.temperatures?.reduce( (acc, moduleVoltages): number =>
			Math.min( acc, ...moduleVoltages )
			, 100 );

		return temperature;
	}

	getMaxTemperature(): number | undefined {
		let temperature: number | undefined = undefined;

		temperature = this.temperatures?.reduce( (acc, moduleVoltages): number =>
			Math.max( acc, ...moduleVoltages )
			, -100 );

		return temperature;
	}

	public updateImbalance(): void
	{
		let old_imbalance_mV = this.imbalance_V
		let old_imbalance_soc = this.imbalance_soc

		this.imbalance_V = this.getMaxCellVoltage()! - this.getMinCellVoltage()!
		this.imbalance_soc = this.soc_from_max_voltage() - this.soc_from_min_voltage()
	}

	public isBalanced(): boolean
	{
		return this.imbalance_V! < Battery.BALANCE_MAX_DIFF_VOLTS
	}

	public soc_from_min_voltage(): number
	{
		return Battery.estimateSOCfromCellVoltage( this.getMinCellVoltage()! );
	}

	public soc_from_max_voltage(): number
	{
		return Battery.estimateSOCfromCellVoltage( this.getMaxCellVoltage()! );
	}



	private writeLog(): void
	{
		if( this.log_is_opening )
		{
			console.log( "Battery: dropping log line while opening log file" )
			return;
		}

		if( this.log_file === undefined )
		{
			this.log_is_opening = true
			fs.promises.open( Battery.LOG_FILE, "a")
				.then( (handle) => {
					this.log_file = handle
					this.log_is_opening = false;
					this.writeLog()
				})
				.catch( (reason) => console.log( "Battery: Failed to open log: " + reason ))
			return;
		}

		if( this.log_is_writing )
		{
			console.log( "dropping battery log due to is writing" );
			return;
		}

		this.log_is_writing = true

		const now = new Date()

		const data = {
			timestamp: now.toISOString(),
			fault: this.fault,
			alert: this.alert,
			voltage: this.getTotalVoltage(),
			current: this.current,
			totalInnerResistance: this.totalInnerResistance,
			is_balancing: this.is_balancing,
			initial_energy_estimate_from_voltage: this.initial_energy_estimate_from_voltage,
			estimated_energy_change: this.estimated_energy_change,
			estimated_energy_from_voltage: this. estimated_energy_from_voltage,
			estimated_energy_from_consumption: this.estimated_energy_from_consumption,
			voltages: this.voltages,
			idleVoltages: this.idleVoltages,
			currentCompensatedVoltages: this.currentCompensatedVoltages,
			temperatures: this.temperatures,
			resistances: this.resistances,
			balancingCells: this.balancingCells,
			imbalance_V: this.imbalance_V,
			imbalance_soc: this.imbalance_soc,
			lastCurrentSetTime: this.lastCurrentSetTime,
		}
		const logline = JSON.stringify(data) + "\n"

		this.log_file!.write(logline)
			.then( () => this.log_is_writing = false)
			.catch( (reason) => console.log( "Log file write failed: " + reason ) )
	}

	toString(): string
	{
		return "Battery State: total voltage: " + this.getTotalVoltage()?.toFixed(2) + 
			" cells: " + this.getMinCellVoltage()?.toFixed(3) + " - " + this.getMaxCellVoltage()?.toFixed(3) +
			" temperature: " + this.getMinTemperature()?.toFixed(2) + " - " + this.getMaxTemperature()?.toFixed(2);
	}
}

export class VESC extends BoatModelAttribute
{
	static readonly LOG_FILE = "/var/log/mjoulnir/vesc.log"

	log_is_opening = false
	log_is_writing = false
	log_file?: FileHandle

	voltage_in = 0
	temp_mos = 0
	temp_mos_1 = 0
	temp_mos_2 = 0
	temp_mos_3 = 0
	temp_motor = 0
    current_motor = 0
    current_in = 0
    current_id = 0
    iq = 0
    rpm = 0
    duty_now = 0
    amp_hours = 0
    amp_hours_charged = 0
    watt_hours = 0
    watt_hours_charged = 0
    tachometer = 0
    tachometer_abs = 0
    position = 0
    fault_code = VESCreader.MCFaultCode.None;
    vesc_id = 0
    vd = 0
    vq = 0

	updateMCValues( voltage_in: number, 
					temp_mos: number, temp_mos_1: number, temp_mos_2: number, temp_mos_3: number, 
					temp_motor: number, current_motor: number, 
					current_in: number, current_id: number,
					iq: number, rpm: number, duty: number, 
					amp_hours: number, energy_charged_ah: number, 
					energy_wh: number, energy_charged_wh: number, 
					tachometer: number, tachometer_abs: number,
					position: number, 
					fault_code: VESCreader.MCFaultCode,
					controller_id: number, 
					vd: number, vq: number): void
	{
		this.voltage_in = voltage_in
		this.temp_mos = temp_mos
		this.temp_mos_1 = temp_mos_1
		this.temp_mos_2 = temp_mos_2
		this.temp_mos_3 = temp_mos_3
		this.temp_motor = temp_motor
		this.current_motor = current_motor
		this.current_in = current_in
		this.current_id = current_id
		this.iq = iq
		this.rpm = rpm
		this.duty_now = duty
		this.amp_hours = amp_hours
		this.amp_hours_charged = energy_charged_ah
		this.watt_hours = energy_wh
		this.watt_hours_charged = energy_charged_wh
		this.tachometer = tachometer
		this.tachometer_abs = tachometer_abs
		this.position = position
		this.fault_code = fault_code
		this.vesc_id = controller_id
		this.vd = vd
		this.vq = vq
		
		this.isValid = true
		/*
		console.log( "Got VESC Values, voltage_in=" + voltage_in + 
			" V, current_in=" + current_in + 
			" A, temp_mos=" + temp_mos.toFixed(1) + 
			" C, duty=" + this.duty_now + ", rpm=" + this.rpm );
		*/
		this.writeLog()
		this.signalUpdated();
	}
	
	estimateCurrent(): number
	{
		return -this.current_in
	}

	private writeLog(): void
	{
		if( this.log_is_opening )
		{
			console.log( "VESC: dropping log line while opening log file" )
			return;
		}

		if( this.log_file === undefined )
		{
			this.log_is_opening = true
			fs.promises.open( VESC.LOG_FILE, "a")
				.then( (handle) => {
					this.log_file = handle
					this.log_is_opening = false;
					this.writeLog()
				})
				.catch( (reason) => console.log( "VESC: Failed to open log: " + reason ))
			return;
		}

		if( this.log_is_writing )
		{
			console.log( "dropping vesc log due to is writing" );
			return;
		}

		this.log_is_writing = true

		const now = new Date()

		const data = {
			voltage_in: this.voltage_in,
			temp_mos: this.temp_mos,
			temp_mos_1: this.temp_mos_1,
			temp_mos_2: this.temp_mos_2,
			temp_mos_3: this.temp_mos_3,
			temp_motor: this.temp_motor,
			current_motor: this.current_motor,
			current_in: this.current_in,
			current_id: this.current_id,
			iq: this.iq,
			rpm: this.rpm,
			duty_now: this.duty_now,
			amp_hours: this.amp_hours,
			amp_hours_charged: this.amp_hours_charged,
			watt_hours: this.watt_hours,
			watt_hours_charged: this.watt_hours_charged,
			tachometer: this.tachometer,
			tachometer_abs: this.tachometer_abs,
			position: this.position,
			fault_code: this.fault_code,
			vesc_id: this.vesc_id,
			vd: this.vd,
			vq: this.vq
		}
		const logline = JSON.stringify(data) + "\n"

		this.log_file!.write(logline)
			.then( () => this.log_is_writing = false)
			.catch( (reason) => console.log( "VESC Log file write failed: " + reason ) )
	}
}

export class HardwareState extends BoatModelAttribute
{
	contactor_on = false
	precharge_on = false

	setPrecharge( prechargeState: boolean )
	{
		Hardware.setPrecharge( prechargeState ? 1 : 0)
		this.precharge_on = this.precharge_on

		this.model.battery.updateEstimatedCurrent()
	}

	setContactor( contactorState: boolean )
	{
		Hardware.setContactor( contactorState ? 1 : 0)
		this.contactor_on = contactorState
	}

	estimateCurrent(): number
	{
		// TODO: use PWM for contactor to reduce power consumption
		if( this.contactor_on )
			return -0.190
		else if( this.precharge_on )
			return -0.164
		else
			return -0.102
	}
}
export class BoatModel extends Model.Model
{
	state = new MJoulnirState(this);
	battery: Battery
	charger = new ChargerState(this);
	vescState = new VESC(this);
	hardware = new HardwareState(this)

	constructor( batteryReaderSerialPortName: string )
	{
		super()
		this.battery = new Battery( this, batteryReaderSerialPortName )
	}

	async start(): Promise<void>
	{
		return this.battery.start()
	}
}
