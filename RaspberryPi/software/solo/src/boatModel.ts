import * as Model from "./model"

export enum State { Booting = 0, Idle = 1, Armed = 2, Charging = 3, Balancing = 4, Active = 5, Error = 6 }
export class MJoulnirState extends Model.ModelAttribute
{
	public state: State;

	constructor()
	{
		super();

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
export class ChargerState extends Model.ModelAttribute
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

export class BatteryState extends Model.ModelAttribute
{
	static readonly BALANCE_MAX_DIFF_VOLTS = 0.002; // 2 mV
	static readonly soc_estimate_breakpoints = [ [0, 3.05], [0.04, 3.29], [0.12, 3.34], [0.26, 3.54], [0.53, 3.68], [0.63, 3.79], [0.98, 4.10], [1.0, 4.18]];

	public static estimateSOCfromCellVoltage( voltage: number ): number
	{
		const breakpoints = BatteryState.soc_estimate_breakpoints;
		let upperBreakpointIndex = breakpoints.length - 1;

		if( voltage < breakpoints[0][1] )
			return 0.0;

		if( voltage >= breakpoints[breakpoints.length-1][1])
			return 1.0;

		for( let i = 0; i < BatteryState.soc_estimate_breakpoints.length; i++ )
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
		let upperBreakpointIndex = BatteryState.soc_estimate_breakpoints.length - 1;

		for( let i = 0; i < BatteryState.soc_estimate_breakpoints.length; i++ )
			if( BatteryState.soc_estimate_breakpoints[i][0] > soc )
			{
				upperBreakpointIndex = i;
				break;
			}

		// linear interpolation
		const lowerBreakpointIndex = upperBreakpointIndex - 1;
		const lowerBreakpoint = BatteryState.soc_estimate_breakpoints[ lowerBreakpointIndex ];
		const upperBreakpoint = BatteryState.soc_estimate_breakpoints[ upperBreakpointIndex ];

		const result = lowerBreakpoint[1] + (soc - lowerBreakpoint[0]) * (upperBreakpoint[1] - lowerBreakpoint[1]) / (upperBreakpoint[0] - lowerBreakpoint[0]);

		return result;
	}

	public voltages: number[][] = [];
	public temperatures: number[][] = [];
	public resistances?: number[][];
	public fault = false;
	public alert = false;
	// imbalance is the difference between the max and min cell voltages when the battery is idle
	public imbalance_V?: number
	public imbalance_soc?: number

//	constructor()
//	{
//		super();
//	}
	// attributes
	// 18 elements - voltages in each cell
	// minCellVoltage
	
	// parameter: array of 3 arrays with 6 voltages
	setVoltages(voltages: number[][]): void
	{
		this.voltages = voltages;
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
		let voltage: number | undefined = undefined;

		voltage = this.voltages?.reduce((acc, moduleVoltages): number => {
			const moduleTotal: number = moduleVoltages.reduce(
				(acc2: number, voltage: number) => acc2 + voltage, 0);

			return acc + moduleTotal;
		}, 0);

		return voltage;
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
		return this.imbalance_V! < BatteryState.BALANCE_MAX_DIFF_VOLTS
	}

	public soc_from_min_voltage(): number
	{
		return BatteryState.estimateSOCfromCellVoltage( this.getMinCellVoltage()! );
	}

	public soc_from_max_voltage(): number
	{
		return BatteryState.estimateSOCfromCellVoltage( this.getMaxCellVoltage()! );
	}

	toString(): string
	{
		return "Battery State: total voltage: " + this.getTotalVoltage()?.toFixed(2) + 
			" cells: " + this.getMinCellVoltage()?.toFixed(3) + " - " + this.getMaxCellVoltage()?.toFixed(3) +
			" temperature: " + this.getMinTemperature()?.toFixed(2) + " - " + this.getMaxTemperature()?.toFixed(2);
	}
}

export class BoatModel extends Model.Model
{
	state = new MJoulnirState();
	batteryState = new BatteryState();
	charger = new ChargerState();
}

export const boatModel = new BoatModel()



