import rfdc from "rfdc";
import * as BoatModel from "./boatModel"
import * as Hardware from "./hardware"
import * as VESC from './vesc';
import * as Charger from './charger';
import * as BatteryReader from './batteryReader';

const clone = rfdc();

// import { assert } from "node:console";

function assert(value: boolean): void 
{
	if( !value )
		throw new Error("assertion failed")
}

async function sleep(seconds: number ): Promise<void>
{
	return new Promise(resolve => setTimeout(resolve, seconds * 1000));
}

class StateMachine
{
}

class State<StateMachineType extends StateMachine>
{
	name: string;
	stateMachine: StateMachineType

	constructor( machine: StateMachineType, name: string ) 
	{ 
		this.name = name;
		this.stateMachine = machine;
	}

	enter(): void 
	// eslint-disable-next-line @typescript-eslint/no-empty-function
	{
	}
}

class MJoulnirState extends State<ElectricDrivetrainStateMachine>
{
	stateID: BoatModel.State;

	constructor( state: BoatModel.State, machine: ElectricDrivetrainStateMachine, name: string )
	{
		super( machine, name );

		this.stateID = state;
	}

	enter(): void
	{
		super.enter()
		this.stateMachine.model.state.set( this.stateID );
	}
}
class BootState extends MJoulnirState
{
	boundListener: () => void;

	constructor( machine: ElectricDrivetrainStateMachine )
	{
		super( BoatModel.State.Booting, machine, "Wait For Battery Pack Status" );
		this.boundListener = this.updated.bind( this );
	}

	enter()
	{
		Hardware.setPrecharge( 0 );
		Hardware.setContactor( 0 );
	
		if( this.stateMachine.model.batteryState.isValid )
			this.checkBattery()
			// transition to the next state
			// this.stateMachine.transitionTo( this.stateMachine.checkBatteryState );
		else
			this.stateMachine.model.batteryState.onChanged( this.boundListener );
	}

	updated()
	{
		// battery model has been updated.
		if( !this.stateMachine.model.batteryState.isValid )
			return;

		this.stateMachine.model.batteryState.updateImbalance()

		// transition to the next state
		// unsubscribe to onChanged
		this.stateMachine.model.batteryState.unOnChanged( this.boundListener );

		this.checkBattery();
	}

	checkBattery()
	{
		const batteryState = this.stateMachine.model.batteryState;

		if( batteryState.fault || batteryState.alert)
		{
			this.stateMachine.batteryErrorState.message = batteryState.fault ? "Fault" : "Alert";
			this.stateMachine.transitionTo( this.stateMachine.batteryErrorState );
			return;
		}

		// eslint-disable-next-line @typescript-eslint/no-non-null-assertion
		if( batteryState.getMinCellVoltage()! < 3.3 )
		{
			this.stateMachine.batteryErrorState.message = "Battery Charge Low";
			this.stateMachine.transitionTo( this.stateMachine.batteryErrorState );
			return;
		}

		// eslint-disable-next-line @typescript-eslint/no-non-null-assertion
		if( batteryState.getMaxTemperature()! > 35 )
		{
			this.stateMachine.batteryErrorState.message = "Battery Hot";
			this.stateMachine.transitionTo( this.stateMachine.batteryErrorState );
			return;
		}

		this.stateMachine.transitionTo( this.stateMachine.turnOnContactorState );
	}
}

class BatteryErrorState extends MJoulnirState
{
	public message = "OK";

	constructor(machine: ElectricDrivetrainStateMachine)
	{
		super( BoatModel.State.Error, machine, "Battery Error");
	}

	enter(): void 
	{
		// TODO: listen for changes to battery if it becomes OK again
	}
}

class TurnOnContactorState extends MJoulnirState
{
	promise: Promise<void> | undefined;

	constructor(machine: ElectricDrivetrainStateMachine)
	{
		super( BoatModel.State.Booting, machine, "Turn On Contactor");
	}

	enter(): void 
	{
		super.enter();
		// turn on precharge
		Hardware.setPrecharge( 1 );
		
		this.promise = sleep( 4 )
		// turn on contactor
			.then( () => { 
					Hardware.setContactor( 1 );
					this.stateMachine.vesc = new VESC.VESCtalker( this.stateMachine.model );
					this.stateMachine.charger = new Charger.Charger( this.stateMachine.vesc, this.stateMachine.model );
					// wait 1 second
					return sleep( 0.5 );
				})
			.then( () => { 
				// turn off precharge
				Hardware.setPrecharge( 0 );
				// goto state idle
				return this.stateMachine.transitionTo( this.stateMachine.armedState );
				})
	}
}

class ArmedState extends MJoulnirState
{
	// my Nedis remote controlled outlet can't handle 10A for very long.
	// default should be 10. But set elsewhere, from Bluetooth?
	static readonly MAX_WALL_CURRENT = 9;

	boundChargerListener: () => void;
	boundBatteryListener: () => void;
	readonly model: BoatModel.BoatModel;

	constructor(machine: ElectricDrivetrainStateMachine)
	{
		super( BoatModel.State.Armed, machine, "Armed");
		this.model = machine.model;
		this.boundChargerListener = this.chargerChanged.bind( this );
		this.boundBatteryListener = this.batteryChanged.bind( this );
	}

	enter(): void 
	{
		super.enter();

		this.model.charger.onChanged( this.boundChargerListener );
		this.model.batteryState.onChanged( this.boundBatteryListener );
		// TODO: monitor battery
		// monitor power switch
		// monitor VESC for going to active state
	}

	transitionTo(state: MJoulnirState): void
	{
		this.model.charger.unOnChanged( this.boundChargerListener );
		this.model.batteryState.unOnChanged( this.boundBatteryListener );

		this.stateMachine.transitionTo( state )
	}

	chargerChanged(): void
	{
		const charger = this.stateMachine.model.charger

		console.log( "Armed State: Charger changed, currently: " + charger.toString() )

		this.considerAction()
	}

	batteryChanged(): void
	{
		const battery = this.stateMachine.model.batteryState

		console.log( "Battery changed: soc=" + (battery.soc_from_min_voltage()!*100).toFixed(0) + "-" 
			+ (battery.soc_from_max_voltage()!*100).toFixed(0) + " %, " + 
			battery.getMaxTemperature()!.toFixed(1) + "°C");

		this.considerAction();
	}

	considerAction(): void
	{
		const charger = this.stateMachine.model.charger
		const soc = this.model.batteryState.soc_from_max_voltage()
		const min_soc = this.model.batteryState.soc_from_min_voltage()

		// TODO: also take battery state into account
		if( charger.canCharge() )
		{
			console.log( "Armed state: Charger can charge, soc is " + (min_soc * 100).toFixed(0) + 
				"-" + (soc * 100).toFixed(0) + " %");

			if( soc < 0.70 )
			{
				// charge to 80% SOC, max 10 A from wall.
				// 
				this.stateMachine.chargeState.setParameters( 0.8, ArmedState.MAX_WALL_CURRENT );
				this.transitionTo( this.stateMachine.chargeState )
			}
			else if( !this.model.batteryState.isBalanced() && 
			         this.model.batteryState.getMaxTemperature()! <= 24 )
				this.transitionTo( this.stateMachine.balancingState )
		}
		else
			console.log( "Armed state: Charger can't charge")
	}
}

class ChargeState extends MJoulnirState
{
	readonly MIN_CHARGING_CURRENT = 1.0;

	readonly batteryState: BoatModel.BatteryState;
	readonly model: BoatModel.BoatModel;

	boundChargerListener: () => void;
	boundBatteryListener: () => void;
	charger?: Charger.Charger
	current_limiting = false;
	at_max_current = false;
	charging_current = 0;
	target_soc?: number; // 0 to 1
	target_max_cell_voltage?: number;
	max_wall_current: number;
	idle_cell_voltages?: number[][];
	internal_resistance_timer?: NodeJS.Timer;
	battery_updates_after_maxCurrent = 0;
	prev_temperature?: number;
	temperature_change = 0;
	temperature_derating = 0;

	constructor(machine: ElectricDrivetrainStateMachine)
	{
		super( BoatModel.State.Charging, machine, "Charge");

		this.model = machine.model;
		this.batteryState = machine.model.batteryState;
		this.max_wall_current = 0;

		this.boundChargerListener = this.chargerChanged.bind( this );
		this.boundBatteryListener = this.batteryChanged.bind( this );
	}

	// target_soc is the desired max state of charge for any cell when charging is finished.
	// it is a value between 0 and 1

	public setParameters( target_soc: number, max_wall_current: number )
	{
		assert( target_soc > 0 );
		assert( target_soc <= 1 );

		this.target_soc = target_soc;
		this.max_wall_current = max_wall_current;
	}

	// caller must set target_soc
	enter( ): void 
	{
		super.enter();

		this.charger = this.stateMachine.charger

		this.battery_updates_after_maxCurrent = 0;
		this.stateMachine.model.charger.onChanged( this.boundChargerListener );
		this.stateMachine.model.batteryState.onChanged( this.boundBatteryListener )

		// this.target_soc = target_soc;
		assert( this.target_soc! >= 0 );
		assert( this.target_soc! <= 1.0 );

		this.current_limiting = false;
		this.charging_current = 0;
		this.at_max_current = false;

		// TODO: ramp up charging currenet
		this.target_max_cell_voltage = BoatModel.BatteryState.estimateCellVoltageFromSOC( this.target_soc! );
		console.log( "Charging: target max cell voltage is " + this.target_max_cell_voltage.toFixed(3) + " V" );

		// TODO: monitor power switch
		// TODO: disable VESC? monitor VESC for going to active state

		this.idle_cell_voltages = clone(this.model.batteryState!.voltages)

		// update battery state every second
		this.stateMachine.batteryReader.setInterval( 1 );

		this.recalculateCharging();

		// estimate internal resistances after 5 seconds of charging.
		// current should have reache stable level by then
		// this.internal_resistance_timer = 
		//	setTimeout( this.estimateResistances.bind(this), 5000 );

		// todo:
		// add timeout if battery data has not been updated in 5 minutes?
	}

	exit( nextState: MJoulnirState )
	{
		this.stateMachine.model.charger.unOnChanged( this.boundChargerListener );
		this.stateMachine.model.batteryState.unOnChanged( this.boundBatteryListener )

		console.log( "Turning off charger" );

		this.charger!.setChargingParameters( 0, 0, false );

		this.stateMachine.batteryReader.setInterval( 60 );

		if( !(this.internal_resistance_timer === undefined) )
		{
			clearTimeout( this.internal_resistance_timer )
			this.internal_resistance_timer = undefined;
		}

		this.stateMachine.transitionTo( nextState );
	}

	recalculateCharging(): void
	{
		// Algorithm: charge until cell with highst voltage reaches 80% SOC
		// which should be equivalent to 3.98 Volts per cell.
		// get highest cell voltage. calculate diff to 3.98. Multiply by 
		// number of cells (18). Use this as initial charging voltage.

		// increasing charging by 0.1 A at a inner resistance of 50 mOhm:
		// Current is distributed among the 74 cells in a group
		// Voltage will increase by .07 mV.
		// 1.5 Amps change will increase voltage by about 1 mV per cell

		const targetCellVoltage = BoatModel.BatteryState.estimateCellVoltageFromSOC( this.target_soc! );
		const maxCellVoltage = this.batteryState.getMaxCellVoltage()!
		// assert( maxCellVoltage <= targetCellVoltage );

		if( maxCellVoltage > (targetCellVoltage + 0.001) )
		{
			console.log( "Aborting charging because max cell volgate=" + maxCellVoltage.toFixed(3) + 
				" V, target=" + targetCellVoltage.toFixed(3) + " V")
			this.abort();
			return;
		}
		const voltageDiff = targetCellVoltage - maxCellVoltage

		const targetPackVoltage = this.batteryState.getTotalVoltage()! + 
			voltageDiff * 18;

		assert( targetPackVoltage < 72 );

		if( !this.current_limiting && (voltageDiff <= 0.002) )
		{
			this.current_limiting = true;
			this.at_max_current = true; // now if not earlier
			console.log( "Switching to current limiting mode")
		}

		const maxPowerIn = 230 * this.max_wall_current // Watts, 10 amps in regular outlet
		const maxPowerOut = maxPowerIn * BoatModel.ChargerState.efficiency;
		const maxChargingCurrent = maxPowerOut * (1 - this.temperature_derating)/ targetPackVoltage;

		if( !this.current_limiting )
		{
			if( this.charging_current < maxChargingCurrent )
			{
				if( voltageDiff < 0.01 )
					this.charging_current += 0.1
				else
					this.charging_current += 1

				if( this.charging_current > maxChargingCurrent )
				{
					this.charging_current = maxChargingCurrent
				}

				if( this.charging_current == maxChargingCurrent )
				{
					console.log( "At max charging current" );
					this.at_max_current = true;
				}
			}
		}

		if( this.current_limiting )
		{
			if( this.charging_current <= this.MIN_CHARGING_CURRENT )
			{
				if( voltageDiff <= 0 )
				{
					// battery update will switch state due to done
					console.log( "Charger update: Charging complete because voltage reached with 100 mA charging");
					this.done();
					return;
					// this.charging_current = 0;
					// this.at_max_current = false;
				}
			}
			else 
              if( this.charging_current >= 3 )
              {
				if( voltageDiff <= 0.002 )
				{
					if( voltageDiff <= 0 )
						this.charging_current -= 1
					else
						this.charging_current -= 0.3
				}
              }
              else
              {
				if( voltageDiff < 0.001 )
				{
					if( voltageDiff <= 0 )
						this.charging_current -= 0.2
					else
						this.charging_current -= 0.1
				
					if( this.charging_current < 0.2 )
						this.charging_current = 0.2

					this.at_max_current = false;
					console.log( "Decreasing charging current" );
				}
			}
		}

		console.log( "max cell voltage=" + maxCellVoltage.toFixed(3) + 
			", diff to target=" + voltageDiff.toFixed(4) + 
			", pack voltage=" + this.batteryState.getTotalVoltage()?.toFixed(1) + 
			" target voltage = " + targetPackVoltage.toFixed(1) + 
			" charging current=" + maxChargingCurrent.toFixed(1) +
			" at max current: " + this.at_max_current +
			" current_limiting: " + this.current_limiting );

		assert( maxChargingCurrent < 40 );

		// record cell voltages before charging, so that we can estimate the 
		// internal resistance of the cell groups
		// the ... thing clonse the array
		this.charger!.setChargingParameters( targetPackVoltage, this.charging_current, true );
	}

	estimateResistances(): void
	{
		assert( this.model.charger!.do_charge! );

		const resistances: number[][] = []
		
		let text = "Resistances (mΩ): ";
		/// one module is 444 cells, divided into 6 groups in series -> 74 cells in parallell
		// current is divided among these 
		const current = this.model.charger!.output_current! / 74;

		for( let module_index = 0; 
             module_index < this.idle_cell_voltages!.length;
             module_index++ )
		{
			resistances[ module_index ] = []
			text += " Module " + module_index + ": [";

			for( let cell_index = 0; 
                 cell_index < this.idle_cell_voltages![module_index].length;
                 cell_index++ )
			{
				const dV = this.model.batteryState.voltages[ module_index ][ cell_index ]
					- this.idle_cell_voltages![ module_index ][ cell_index ];
				// console.log( "dV[ " + module_index + " ][ " + cell_index + "]=" + dV);
				const resistance = dV / current;
				resistances[ module_index ][ cell_index ] = resistance;
				if( cell_index != 0 )
					text += ", "
				text += (resistance * 1000).toFixed(0);
			}
			text += " ]\n";
		}

		// this.model.batteryState.setResistances( resistances );
		console.log( text );

		this.model.batteryState.resistances = resistances;
		this.model.batteryState.signalUpdated();
	}

	chargerChanged(): void
	{
		const charger = this.stateMachine.model.charger

		console.log( "Charge State: Charger changed, currently: " + charger.toString() )
		// assert( charger.canCharge() );

		if( !charger.canCharge() || charger!.output_voltage! > 75.6 || charger!.output_current! > 40 )
		{
			console.log( "Aborting charging due to charger" );
			this.abort();
		}
	}

	abort(): void
	{
		this.charger!.setChargingParameters( 0, 0, false );

		console.log( "aborted charging, return to armed mode" );
		this.exit( this.stateMachine.armedState );
	}

	done(): void
	{
		console.log( "Charging done, transitioning...");

		if( this.batteryState.isBalanced() )
			this.exit( this.stateMachine.armedState );
		else
			this.exit( this.stateMachine.balancingState );
	}

	batteryChanged(): void
	{
		const batteryState = this.stateMachine.model.batteryState
		const newTemperature = batteryState.getMaxTemperature()!

		if( this.at_max_current )
			this.battery_updates_after_maxCurrent++;

		console.log( "Charge State: Battery changed, currently: " + batteryState.toString() )

		// if the battery is not balanced, we need a re-charge after balancing anyway,
		// so we go to balancing when charge current has gone down to 5A 
		if( batteryState.getMaxCellVoltage()! >= (this.target_max_cell_voltage! - 0.002) && 
			((batteryState.isBalanced() && this.charging_current <= 0.5) ||
			 (!batteryState.isBalanced() && this.charging_current < 5)))
		{
			this.done();
			// charging is done
			/*
			console.log( "Charging is done.")
			this.charger!.setChargingParameters( 0, 0, false );

			// if( batteryState.isBalanced() )
			this.exit( this.stateMachine.armedState )
			*/
				/*
			else
				this.exit( this.stateMachine.balancingState )
				*/
		}

		// TODO: stop charging if over temperature or over voltage
		if( newTemperature >= 35 )
		{
			console.log( "Aborting charging due to battery over temperature 35 C");
			this.abort();
			return;
		}

		if( this.prev_temperature === undefined )
			this.prev_temperature = newTemperature;
		else
		{
			if( newTemperature != this.prev_temperature)
			{
				this.temperature_change = newTemperature - this.prev_temperature
				this.prev_temperature = newTemperature;
			}
		}

		if( newTemperature > 30 && this.temperature_change > 0 )
		{
			if( this.temperature_derating < 0.8 )
				this.temperature_derating += 0.1;
		}
		else if( this.temperature_derating > 0.01 && 
                 newTemperature < 30 && 
                 this.temperature_change < 0 ) 
		{
			this.temperature_derating -= 0.01;
		}

		if( this.temperature_derating > 0.01 )
			console.log( "temperature derating: " + (this.temperature_derating * 100).toFixed(0) + "%")

		if( this.battery_updates_after_maxCurrent == 5 )
			this.estimateResistances();

		this.recalculateCharging();
	}

}

class BalancingState extends MJoulnirState
{
	static readonly BALANCING_PASS_DURATION = 2 * 60

	readonly batteryState: BoatModel.BatteryState;
	readonly model: BoatModel.BoatModel;
	readonly batteryReader: BatteryReader.BatteryReader;

	readonly boundBatteryListener: () => void;
	readonly boundChargerListener: () => void;
	// readonly boundStartBalancing: () => void;

	charger?: Charger.Charger

	initialWaitTimeout?: NodeJS.Timer;
	is_balancing = false;
	cellsToBalance: boolean[][] = [];
	initialVoltages: number[][] = [];
	targetVoltage = 0;
	balanceTimer?: NodeJS.Timer;
	settleTimer?: NodeJS.Timer;

	constructor(machine: ElectricDrivetrainStateMachine)
	{
		super( BoatModel.State.Balancing, machine, "Balancing");

		this.model = machine.model;
		this.batteryState = machine.model.batteryState;
		this.batteryReader = machine.batteryReader;

		this.boundBatteryListener = this.batteryChanged.bind( this );
		this.boundChargerListener = this.chargerChanged.bind( this );
		// this.boundStartBalancing = this.startBalancing.bind( this );
	}

	enter( ): void 
	{
		super.enter();

		this.charger = this.stateMachine.charger

		this.batteryState.onChanged( this.boundBatteryListener );
		this.model.charger.onChanged( this.boundChargerListener );

		// we don't need a high update interval, we poll the battery when required
		// this.stateMachine.batteryReader.setInterval( 60 );

		// TODO: monitor power switch
		// TODO: disable VESC? monitor VESC for going to active state

		// first, wait one minute to let all cell voltages settle
		this.is_balancing = false;
		console.log( "Waiting one minute...");
		// temporarily changed to 10 seconds for testing
		this.initialWaitTimeout = setTimeout( this.startBalancing.bind(this), /* 60 */ 10 * 1000 );
	}

	async startBalancing(): Promise<void>
	{
		return this.batteryReader.poll(true)
			.then( () => {
				this.printImbalance()
				this.initialWaitTimeout = undefined;

				this.initialVoltages = this.batteryState.voltages;
				this.targetVoltage = this.batteryState.getMinCellVoltage()!;
				console.log( "Target voltage=" + this.targetVoltage.toFixed(3) + " V" );
				return this.startBalancingPass();
			})
	}

	async startBalancingPass(): Promise<void>
	{
		this.cellsToBalance = this.calculateCellsToBalance();

		// Turn on balancing for all cells more than 5 mV above the lowest
		// cell
		this.batteryReader.setBalanceTimer( BalancingState.BALANCING_PASS_DURATION )
			.then( () => this.batteryReader.balance( this.cellsToBalance ) )
			.then( () => { this.is_balancing = true;
				console.log( "Setting balanceTimer")
				this.balanceTimer = setTimeout( this.finishBalancePass.bind( this ),
					BalancingState.BALANCING_PASS_DURATION * 1000 ) } )
			.catch( (error) => { 
				console.log( "Start balancing failed: " + error );
				console.log( "stack: " + error.stack );
				return this.startBalancingPass();
				// this.exit( this.stateMachine.armedState );
			})

		// next batteryChanged will cause balancing to be updated
	}

	calculateCellsToBalance(): boolean[][]
	{
		// Read all cell voltages
		const voltages = this.batteryState.voltages;
		// const maxVoltage = this.batteryState.getMaxCellVoltage();
		const cellsToBalance: boolean[][] = [];
		const minVoltage = this.batteryState.getMinCellVoltage()!

		if( Math.round(minVoltage * 1000) != Math.round(this.targetVoltage * 1000))
		{
			console.log( "Changing target voltage from " + this.targetVoltage.toFixed(3) + 
				" to " + minVoltage.toFixed(3))
			this.targetVoltage = minVoltage;
		}

		console.log( "calculate cells to balance:")
		let line = ""

		for( let moduleIndex = 0; moduleIndex < voltages.length; moduleIndex++ )
		{
			line = "[ "
			cellsToBalance[ moduleIndex ] = [];
			for( let cellGroupIndex = 0; cellGroupIndex < voltages[moduleIndex].length; cellGroupIndex++)
			{
				let doBalance: boolean

				if( voltages[ moduleIndex ][ cellGroupIndex ] > (this.targetVoltage + BoatModel.BatteryState.BALANCE_MAX_DIFF_VOLTS) )
					doBalance = true;
				else
					doBalance = false;

				cellsToBalance[ moduleIndex ][ cellGroupIndex ] = doBalance;
				if( cellGroupIndex > 0)
					line += ", ";

				const v = voltages[ moduleIndex ][ cellGroupIndex ]
				// console.log( "voltages[][]=" + v );
				line += v.toFixed(3) + " V " + (doBalance ? "*" : "");
			}
			line += " ]";
			// console.log( line );
		}

		return cellsToBalance;
	}

	finishBalancePass()
	{
		console.log( "Turning off balancing for evaluation")
		this.balanceTimer = undefined

		// turn off balancing
		this.batteryReader.stopBalancing()
			.then( () => {
				console.log( "Waiting 20s for cells to settle")
				this.settleTimer = setTimeout( this.evaluateBalancing.bind(this), 20000 )
			})
			.catch( error => {
				console.log( "failed top stop balancing: " + error );
				console.log( error.stack );
				this.finishBalancePass(); // redo it.
			})
	}

	evaluateBalancing()
	{
		// const newCellsToBalance = this.calculateCellsToBalance();
		var line = "";
		var count = 0;

		this.settleTimer = undefined;

		console.log( "Eval: polling battery")

		this.batteryReader.poll(true)
			.then( () => {
				this.printCellVoltages();
				this.printImbalance();

				const count = this.batteryState.voltages.reduce( (acc, cellVoltages) => cellVoltages.reduce( (acc, v) => {
					if( v > this.targetVoltage + BoatModel.BatteryState.BALANCE_MAX_DIFF_VOLTS)
						return acc + 1;
					else
						return acc;
				}, acc), 0)
				// print cell volages
				/*
				for( let moduleIndex = 0; moduleIndex < this.batteryState.voltages.length; 
					moduleIndex++)
				{
					// const cells = newCellsToBalance[ moduleIndex ];
					const voltages = this.batteryState.voltages[ moduleIndex ];

					line = "[ ";
					for( let cellIndex = 0; cellIndex < voltages.length; cellIndex++ )
					{
						const v = voltages[ cellIndex ];
						if( cellIndex != 0 )
							line += ", ";
						line += v.toFixed(3);
						
						if( v > this.targetVoltage )
						{
							line += "*";
							count++;
						}
					}
					console.log( line );
				}
				*/
				console.log( "count=" + count)
				if( count > 0 )
					this.startBalancingPass();
				else
					this.done();
			})
	}

	batteryChanged(): void
	{
		// if( !this.is_balancing )
		//	return;

		// algorithm must be: enable balancing, wait, turn off balancing,
		// wait? measure, repeat. 
		// No! Why?
/*
		const newCellsToBalance = this.calculateCellsToBalance();

		if( newCellsToBalance != this.cellsToBalance )
		{
			this.cellsToBalance = newCellsToBalance;

			const count_cells = this.cellsToBalance.reduce( (acc, moduleCells) => 
				moduleCells.reduce( (acc, doBalance) => { 
					if( doBalance ) 
						return acc + 1 
					else
						return acc
				}, acc), 0);

			console.log( count_cells + " cells remain to be balanced: " );
			*/
/*
			if( count_cells == 0 )
				this.done()
			else
				this.batteryReader.
*/
		// }

		// console.log( "Cell voltages: ")
		// this.printCellVoltages();
		console.log( "Battery temperatures: " + 
			this.batteryState.getMinTemperature()!.toFixed(1) + " - "  + 
			this.batteryState.getMaxTemperature()!.toFixed(1) )
		
		// play it safe. 25 C may mean it is warmer somewhere inside the battery. 
		// Although it's probably the balancing resistors' dissipation that leaks
		// into the battery module
		if( this.batteryState.getMaxTemperature()! > 25 )
		{
			console.log( "Pausing balancing because battery temperature is over 25 C");
			this.exit( this.stateMachine.armedState );
		}
	}

	printImbalance()
	{
		console.log( "Imbalance: " + this.batteryState.imbalance_V!.toFixed(4) + " V, " + 
					 (this.batteryState.imbalance_soc! * 100).toFixed(1) + "% soc")
	}

	printCellVoltages()
	{
		const allVoltages = this.batteryState.voltages;
		let line = "";

		for( let moduleIndex = 0; moduleIndex < allVoltages.length; moduleIndex++)
		{
			const voltages = allVoltages[ moduleIndex ];

			line = "[ ";
			for( let cellIndex = 0; cellIndex < voltages.length; cellIndex++ )
			{
				if( cellIndex != 0 )
					line += ", ";
				line += voltages[ cellIndex ].toFixed(3);
				if( voltages[cellIndex] > (this.targetVoltage + BoatModel.BatteryState.BALANCE_MAX_DIFF_VOLTS))
					line += "*"
			}
			line += " ]";
			console.log( line )
		}
	}

	done(): void
	{
		this.stateMachine.chargeState.target_soc = 0.8;
		this.exit( this.stateMachine.chargeState );
	}

	abort(): void
	{
		this.exit( this.stateMachine.armedState );
	}

	exit( nextState: MJoulnirState ): void
	{
		// TODO: turn off all balancing

		if( !(this.initialWaitTimeout === undefined) )
		{
			clearTimeout( this.initialWaitTimeout )
			this.initialWaitTimeout = undefined;
		}
		
		if( !(this.balanceTimer === undefined) )
		{
			clearTimeout( this.balanceTimer )
			this.balanceTimer = undefined;
		}

		if( !(this.settleTimer === undefined) )
		{
			clearTimeout( this.settleTimer )
			this.settleTimer = undefined;
		}

		this.stateMachine.model.charger.unOnChanged( this.boundChargerListener );
		if( this.is_balancing )
			this.stateMachine.model.batteryState.unOnChanged( this.boundBatteryListener )

		this.is_balancing = false;
		this.stateMachine.transitionTo( nextState );
	}
	
	chargerChanged(): void
	{
		const charger = this.stateMachine.model.charger

		if( !charger.canCharge() ) {
			console.log( "Aborted balancing because charger lost ");
			this.abort();
		}
	}
}

export class ElectricDrivetrainStateMachine extends StateMachine
{
	state: MJoulnirState;

	vesc?: VESC.VESCtalker;
	charger?: Charger.Charger;
	readonly batteryReader: BatteryReader.BatteryReader;

	readonly model: BoatModel.BoatModel;
	readonly batteryState: BoatModel.BatteryState
	readonly bootState = new BootState(this);
	readonly batteryErrorState = new BatteryErrorState(this);
	readonly turnOnContactorState = new TurnOnContactorState(this);	
	readonly armedState: ArmedState
	readonly chargeState
	readonly balancingState

	constructor( model: BoatModel.BoatModel, batteryReaderSerialPortName: string )
	{
		super();
		this.model = model;

		this.batteryState = model.batteryState;
		// these must be created after the state machine's model is assigned
		this.armedState = new ArmedState(this);
		this.chargeState = new ChargeState(this);

		this.batteryReader = new BatteryReader.BatteryReader( batteryReaderSerialPortName, BoatModel.boatModel);

		// balancingState must be created after the batteryReader
		this.balancingState = new BalancingState(this);

		this.state = this.bootState;
	}

	start( ): void
	{
		this.batteryReader.start(60)
			.then( () => this.batteryReader.poll(true) )
			.then( () => {
				console.log( "Imbalance: " + this.model.batteryState.imbalance_V!.toFixed(3) + " V, " +
					(this.batteryState.imbalance_soc! * 100).toFixed(1) + "% soc" )
			})
			.catch( (error) => {
				console.log( "Failed to start battery reader: " + error );
				console.log( "Stack: " + error.stack ); // check battery once a minute
			})

		this.state.enter();
	}

	transitionTo( state: MJoulnirState ): void
	{
		console.log( "Transitioning to state " + state.name );

		this.state = state;
		return this.state.enter();
	}
}
