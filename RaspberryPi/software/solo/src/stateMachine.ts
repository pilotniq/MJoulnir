import rfdc from "rfdc";
import * as BoatModel from "./boatModel"
import * as VESCble from 'vesc-ble'
import * as VESC from './vesc';
// import * as Charger from './elconCharger';
// import { Charger } from './chargerInterface'

import { timeStamp } from "node:console";

const clone = rfdc();

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

	// undoes enter
	exit(): void
	{}
}

abstract class MJoulnirState extends State<ElectricDrivetrainStateMachine>
{
	stateID: BoatModel.State;

	constructor( state: BoatModel.State, machine: ElectricDrivetrainStateMachine, name: string )
	{
		super( machine, name );

		this.stateID = state;
	}

	enter(): void
	{
		console.log( "Entering state " + this.stateID + ": " + this.name)
		super.enter()
		this.stateMachine.model.state.set( this.stateID );
	}

	exit(): void
	{
		super.exit();
	}

	abstract canEnter(): boolean

	transitionTo(state: MJoulnirState): void
	{
		this.exit();
		this.stateMachine.transitionTo( state )
	}

	// return true if permitted
	requestTransition( nextState: MJoulnirState ): boolean
	{
		return false
	}
}

// require App to switch from this state to armed?
// that would work as a "key" to the boat as well
class IdleState extends MJoulnirState
{
	boundBatteryListener: () => void;
	// battery: BoatModel.Battery

	constructor( machine: ElectricDrivetrainStateMachine )
	{
		super( BoatModel.State.Idle, machine, "Idle" );
		this.boundBatteryListener = this.batteryUpdated.bind( this );
		// this.battery = machine.battery
	}

	canEnter(): boolean
	{
		return true;
	}

	enter()
	{
		super.enter()
		const hardware = this.stateMachine.model.hardware
		hardware.setPrecharge( false );
		hardware.setContactor( false );
	
		const battery = this.stateMachine.battery

		/* this.stateMachine.model. */ battery.onChanged( this.boundBatteryListener );
	
		// poll battery every 10 minutes
		battery.setPollingInterval( 10 * 60)
/*
		if( this.stateMachine.model.battery.isValid )
			this.checkBattery()
			// transition to the next state
			// this.stateMachine.transitionTo( this.stateMachine.checkBatteryState );
		else
		*/
	}

	exit()
	{
		const battery = this.stateMachine.battery

		battery.unOnChanged( this.boundBatteryListener );
		battery.setPollingInterval( BoatModel.Battery.DEFAULT_POLLING_INTERVAL )
	}

	batteryUpdated()
	{
		// battery model has been updated.
		if( !this.stateMachine.model.battery.isValid )
			return;

		// this.stateMachine.model.battery.updateImbalance()

		// transition to the next state
		// unsubscribe to onChanged

		this.checkBattery();
	}

	checkBattery()
	{
		const battery = this.stateMachine.model.battery;

		// TODO: let battery determine if it is good or bad
		if( battery.fault || battery.alert)
		{
			this.stateMachine.batteryErrorState.message = battery.fault ? "Fault" : "Alert";
			this.stateMachine.transitionTo( this.stateMachine.batteryErrorState );
			return;
		}

		// eslint-disable-next-line @typescript-eslint/no-non-null-assertion
		if( battery.getMinCellVoltage()! < 3.3 )
		{
			this.stateMachine.batteryErrorState.message = "Battery Charge Low";
			this.stateMachine.transitionTo( this.stateMachine.batteryErrorState );
			return;
		}

		// eslint-disable-next-line @typescript-eslint/no-non-null-assertion
		if( battery.getMaxTemperature()! > 35 )
		{
			this.stateMachine.batteryErrorState.message = "Battery Hot";
			this.stateMachine.transitionTo( this.stateMachine.batteryErrorState );
			return;
		}

		// this.stateMachine.transitionTo( this.stateMachine.turnOnContactorState );
	}

	requestTransition( nextState: MJoulnirState ): boolean
	{
		const battery = this.stateMachine.battery

		switch( nextState )
		{
			case this.stateMachine.armedState:
				if( battery.isValid && !battery.isDangerouslyLow() )
				{
					console.log( "Transitioning to turnOnContactorState" )
					this.transitionTo( this.stateMachine.turnOnContactorState )
					return true;
				}
				else
					return false;
				break;

			default:
				return false;
		}
	}	
}

class BatteryErrorState extends MJoulnirState
{
	public message = "OK";

	constructor(machine: ElectricDrivetrainStateMachine)
	{
		super( BoatModel.State.Error, machine, "Battery Error");
	}

	canEnter(): boolean
	{
		return true;
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
		super( BoatModel.State.Arming, machine, "Turn On Contactor");
	}

	canEnter(): boolean
	{
		// maybe validate that battery has sufficient charge OR charger is online
		return true;
	}

	enter(): void 
	{
		super.enter();

		// turn on precharge
		const hardware = this.stateMachine.model.hardware

		hardware.setPrecharge( true );
		
		this.promise = sleep( 4 )
		// turn on contactor
			.then( () => { 
					let vesc = this.stateMachine.model.vescState
					hardware.setContactor( true );
					// this.stateMachine.vesc = new VESC.VESCtalker( this.stateMachine.model );
					vesc.connect()
					// this.stateMachine.vesc.connect()
					// this.stateMachine.charger = new Charger.ELCONCharger( vesc.vescTalker, this.stateMachine.model );
					// wait 1 second
					return sleep( 0.5 );
				})
			.then( () => { 
				// turn off precharge
				hardware.setPrecharge( false );
				// goto state idle
				return this.stateMachine.transitionTo( this.stateMachine.armedState );
				})
			.catch(reason => console.log( "TurnOnContactorState enter failed: " + reason ))
	}
}

class ArmedState extends MJoulnirState
{
	// my Nedis remote controlled outlet can't handle 10A for very long.
	// default should be 10. But set elsewhere, from Bluetooth?
	// static readonly MAX_WALL_CURRENT = 9;

	boundChargerListener: () => void;
	boundBatteryListener: () => void;
	boundESCListener: () => void;
	readonly model: BoatModel.BoatModel;
	pauseAutoCharge = false

	constructor(machine: ElectricDrivetrainStateMachine)
	{
		super( BoatModel.State.Armed, machine, "Armed");
		
		this.model = machine.model;
		this.boundBatteryListener = this.batteryChanged.bind( this );
		this.boundChargerListener = this.chargerChanged.bind( this );
		this.boundESCListener = this.escChanged.bind( this );
	}

	canEnter(): boolean
	{
		// validate that battery has sufficient charge?
		return true;
	}

	enter(): void 
	{
		console.log( "Entering armedState.enter" );
		super.enter();

		this.model.charger.onChanged( this.boundChargerListener );
		this.model.battery.onChanged( this.boundBatteryListener );
		this.model.vescState.onChanged( this.boundESCListener );

		this.model.vescState.setPollMCValueInterval( 2 );

		// TODO: monitor battery
		// monitor power switch
		// monitor VESC for going to active state
		console.log( "Leaving armedState.enter" );
	}

	exit(): void
	{
		console.log( "chargeState.exit: pauseAutoCharge = false")
		this.pauseAutoCharge = false

		this.model.charger.unOnChanged( this.boundChargerListener );
		this.model.battery.unOnChanged( this.boundBatteryListener );
		this.model.vescState.unOnChanged( this.boundESCListener );

		this.model.vescState.setPollMCValueInterval( 0 );
	}

	chargerChanged(): void
	{
		const charger = this.stateMachine.model.charger

		console.log( "Armed State: Charger changed, currently: " + charger.toString() )

		this.considerAction()
	}

	batteryChanged(): void
	{
		const battery = this.stateMachine.model.battery

		console.log( "Battery changed: soc=" + (battery.soc_from_min_voltage()!*100).toFixed(0) + "-" 
			+ (battery.soc_from_max_voltage()!*100).toFixed(0) + " %, " + 
			battery.getMaxTemperature()!.toFixed(1) + "°C");

		this.considerAction();
	}

	escChanged(): void
	{
		const esc = this.model.vescState

		if( esc.duty_now != 0 )
		{
			console.log( "duty_now=" + esc.duty_now )
			this.transitionTo( this.stateMachine.activeState );
		}
	}

	considerAction(): void
	{
		if( this.pauseAutoCharge )
		{
			console.log( "considerAction: Not charging because pauseAutoCharge")
			return
		}
		const charger = this.stateMachine.model.charger
		const soc = this.model.battery.soc_from_max_voltage()
		const min_soc = this.model.battery.soc_from_min_voltage()

		// TODO: also take battery state into account
		if( charger.canCharge() )
		{
			console.log( "Armed state: Charger can charge, soc is " + (min_soc * 100).toFixed(0) + 
				"-" + (soc * 100).toFixed(0) + " %");

			if( soc < (this.model.charger.target_soc - 0.05) ) // just while testing balancing, raise to 0.7?
			{
				// charge to 80% SOC, max 10 A from wall.
				// 
				// this.stateMachine.chargeState.setParameters( 0.8, ArmedState.MAX_WALL_CURRENT );
				this.transitionTo( this.stateMachine.chargeState )
			}
			else if( this.model.battery.isBalanced() && 
			         this.model.battery.getMaxTemperature()! <= 24 )
				this.transitionTo( this.stateMachine.balancingState )
		}
		else
			console.log( "Armed state: Charger can't charge")
	}

	requestTransition( nextState: MJoulnirState ): boolean
	{
		console.log( "ArmedState: got transition request to " + nextState.name )
		switch( nextState )
		{
			case this.stateMachine.idleState:
				this.transitionTo( nextState )
				return true;

			case this.stateMachine.chargeState:
				console.log( "ArmedState: detected=" + this.model.charger.detected + ", powered=" + this.model.charger.powered )

				if(this.model.charger.detected && this.model.charger.powered)
				{
					console.log( "Transitioning!" )
					this.transitionTo( nextState )
					return true;
				}
				else
				{
					console.log( "Not Transitioning." )
					return false
				}
				break

			default:
				return false;
		}
	}

}

class ActiveState extends MJoulnirState
{
	static readonly ZERO_DUTY_SECONDS_BEFORE_SWITCH = 10

	readonly battery: BoatModel.Battery;
	readonly model: BoatModel.BoatModel;

	boundBatteryListener: () => void;
	boundESCListener: () => void;

	zeroDutyTimer?: NodeJS.Timer

	constructor(machine: ElectricDrivetrainStateMachine)
	{
		super( BoatModel.State.Active, machine, "Active");

		this.model = machine.model;
		this.battery = machine.model.battery;

		this.boundBatteryListener = this.batteryChanged.bind( this );
		this.boundESCListener = this.escChanged.bind( this );
		// this.boundStartBalancing = this.startBalancing.bind( this );
	}

	canEnter(): boolean
	{		
		return true;
	}

	batteryChanged(): void
	{
		const battery = this.model.battery

		if( battery.isDangerouslyLow() )
		{
			console.log( "Active state: Battery dangerously low, transitioning to Error" );
			this.transitionTo( this.stateMachine.batteryErrorState );
		}
	}

	enter(): void 
	{
		console.log( "Entering activeState.enter" );
		super.enter();

		this.model.battery.onChanged( this.boundBatteryListener );
		this.model.vescState.onChanged( this.boundESCListener );

		this.battery.setPollingInterval(10);
		this.model.vescState.setPollMCValueInterval( 2 );

		this.zeroDutyTimer = undefined
		// TODO: monitor battery
		// monitor power switch
	}

	exit(): void
	{
		super.exit()

		this.model.battery.unOnChanged( this.boundBatteryListener );
		this.model.vescState.unOnChanged( this.boundESCListener );

		this.battery.setPollingInterval(BoatModel.Battery.DEFAULT_POLLING_INTERVAL);
		this.model.vescState.setPollMCValueInterval( 0 );

		if( this.zeroDutyTimeout !== undefined )
		{
			clearTimeout( this.zeroDutyTimer! )
			this.zeroDutyTimer = undefined
		}
	}

	escChanged(): void
	{
		if( this.model.vescState.duty_now == 0 )
		{
			if(this.zeroDutyTimer === undefined)
				this.zeroDutyTimer = setTimeout( this.zeroDutyTimeout.bind(this), ActiveState.ZERO_DUTY_SECONDS_BEFORE_SWITCH * 1000 );
		}
		else
		{
			if(this.zeroDutyTimer !== undefined)
			{
				clearTimeout(this.zeroDutyTimer!)
				this.zeroDutyTimer = undefined
			}
		}
	}

	zeroDutyTimeout(): void
	{
		this.transitionTo( this.stateMachine.armedState )
	}
}

class ChargeState extends MJoulnirState
{
	readonly battery: BoatModel.Battery;
	readonly model: BoatModel.BoatModel;

	boundChargerListener: () => void;
	boundBatteryListener: () => void;

	is_paused = false
	pauseTimer?: NodeJS.Timer

	charger: BoatModel.ChargerState

	resistances_estimated = false
	current_limiting = false;
	at_max_current = false;
	at_max_current_time = 0;
	resume_time = 0;
	charging_current = 0;
	latest_charging_current = 0;
	// target_soc?: number; // 0 to 1
	target_max_cell_voltage?: number
	target_pack_voltage = 0
	// max_wall_current: number;
	idle_cell_voltages?: number[][];
	max_current_voltages?: number[][];
	internal_resistance_timer?: NodeJS.Timer;
	// battery_updates_after_maxCurrent = 0;
	prev_temperature?: number;
	temperature_change = 0;
	temperature_derating = 0;
	latest_max_wall_current = 0;
	latest_target_soc = 0;

	constructor(machine: ElectricDrivetrainStateMachine)
	{
		super( BoatModel.State.Charging, machine, "Charge");

		this.model = machine.model;
		this.charger = this.model.charger
		this.battery = machine.model.battery;
		// this.max_wall_current = 0;

		this.boundChargerListener = this.chargerChanged.bind( this );
		this.boundBatteryListener = this.batteryChanged.bind( this );

		// todo: listen to changes in charger model parameters
	}

	// target_soc is the desired max state of charge for any cell when charging is finished.
	// it is a value between 0 and 1
/*
	public setParameters( target_soc: number, max_wall_current: number )
	{
		assert( target_soc > 0 );
		assert( target_soc <= 1 );

		this.target_soc = target_soc;
		this.max_wall_current = max_wall_current;
	}
*/
	canEnter(): boolean
	{
		// check if charger is online
		return this.stateMachine.model.charger.canCharge();
	}

	// caller must set target_soc
	enter( ): void 
	{
		super.enter();

		this.charger = this.model.charger

		// this.battery_updates_after_maxCurrent = 0;
		this.stateMachine.model.charger.onChanged( this.boundChargerListener );
		this.stateMachine.model.battery.onChanged( this.boundBatteryListener )

		console.log( "ChargeState.enter(): charger target soc = " + this.charger.target_soc!)
		// this.target_soc = target_soc;
		assert( this.charger.target_soc! >= 0 );
		assert( this.charger.target_soc! <= 1.0 );

		this.current_limiting = false;
		this.charging_current = 0;
		this.at_max_current = false;
		this.resistances_estimated = false
		this.latest_max_wall_current = this.model.charger.max_wall_current
		this.latest_target_soc = this.model.charger.target_soc

		// TODO: ramp up charging currenet
		this.target_max_cell_voltage = BoatModel.Battery.estimateCellVoltageFromSOC( this.charger.target_soc! );
		console.log( "Charging: target max cell voltage is " + this.target_max_cell_voltage.toFixed(3) + " V" );

		// TODO: monitor power switch
		// TODO: disable VESC? monitor VESC for going to active state

		this.idle_cell_voltages = clone(this.model.battery.voltages)

		// update battery state every second
		this.battery.setPollingInterval( 1 );

		// this assert triggers
		assert(this.pauseTimer === undefined )
		// setTimeout( this.estimateResistances.bind(this), 5000 );
		// this.pauseTimer = setTimeout( this.pauseCharging.bind(this), ChargeState.CHARGE_PERIOD_DURATION * 1000 )

		this.recalculateCharging();

		// estimate internal resistances after 5 seconds of charging.
		// current should have reache stable level by then
		// this.internal_resistance_timer = 
		//	setTimeout( this.estimateResistances.bind(this), 5000 );

		// todo:
		// add timeout if battery data has not been updated in 5 minutes?
	}

	pauseCharging(): void
	{
		// TODO: THis assert has triggered
		if( !this.is_paused )
		{
			assert( !this.is_paused )

			console.log( (new Date().toISOString()) + ": Pausing charging" )

			this.is_paused = true

			this.charger.setChargingParameters( this.target_pack_voltage, this.charging_current, false );

			console.log( "pauseCharging: starting pause timer for resume @ " + (new Date).toISOString() )
		}
		else
		{
			console.log( "Restarting pause" );
			clearTimeout( this.pauseTimer! );
		}
		this.pauseTimer = setTimeout( this.resumeCharging.bind(this), BoatModel.ChargerState.PAUSE_PERIOD_DURATION * 1000 )
	}

	resumeCharging(): void
	{
		assert( this.is_paused )

		console.log( (new Date().toISOString()) + ": Resuming charging")
		this.is_paused = false

		if( !this.resistances_estimated )
		{
			console.log( "Estimating resistances" )

			this.battery.estimateResistances( this.latest_charging_current, this.battery.voltages, this.max_current_voltages! )
			this.resistances_estimated = true
		}

		this.charger.setChargingParameters( this.target_pack_voltage, this.charging_current, true );

		this.resume_time = Date.now() / 1000.0

		console.log( (new Date().toISOString()) + ": Starting pauseTimer for pause, duration=" + 
					 BoatModel.ChargerState.CHARGE_PERIOD_DURATION)
		this.pauseTimer = setTimeout( this.pauseCharging.bind(this), 
									  BoatModel.ChargerState.CHARGE_PERIOD_DURATION * 1000 )
	}

	exit( )
	{
		this.stateMachine.model.charger.unOnChanged( this.boundChargerListener );
		this.stateMachine.model.battery.unOnChanged( this.boundBatteryListener )

		clearTimeout( this.pauseTimer! )
		this.pauseTimer = undefined

		console.log( "Turning off charger" );

		this.charger.setChargingParameters( 0, 0, false );

		this.battery.setPollingInterval( BoatModel.Battery.DEFAULT_POLLING_INTERVAL );

		if( !(this.internal_resistance_timer === undefined) )
		{
			clearTimeout( this.internal_resistance_timer )
			this.internal_resistance_timer = undefined;
		}
	}

	recalculateCharging(): void
	{
		// Algorithm: charge until cell with highst voltage reaches this.target_soc (currently 80%) SOC
		// which should be equivalent to 3.98 Volts per cell.
		// get highest cell voltage. calculate diff to 3.98. Multiply by 
		// number of cells (18). Use this as initial charging voltage.

		// increasing charging by 0.1 A at a inner resistance of 50 mOhm:
		// Current is distributed among the 74 cells in a group
		// Voltage will increase by .07 mV.
		// 1.5 Amps change will increase voltage by about 1 mV per cell

		const targetCellVoltage = BoatModel.Battery.estimateCellVoltageFromSOC( this.charger.target_soc! );
		const maxCellVoltage = this.battery.getMaxCellVoltage()!
		// assert( maxCellVoltage <= targetCellVoltage );

		if( maxCellVoltage > (targetCellVoltage + 0.001) )
		{
			console.log( "Aborting charging because max cell volgate=" + maxCellVoltage.toFixed(3) + 
				" V, target=" + targetCellVoltage.toFixed(3) + " V")
			this.abort();
			return;
		}
		const voltageDiff = targetCellVoltage - maxCellVoltage

		this.target_pack_voltage = this.battery.getTotalVoltage()! + 
			voltageDiff * 18;

		// TODO: Increase to 75.6
		assert( this.target_pack_voltage <= 75.6 );

		if( !this.current_limiting && (voltageDiff <= 0.002) )
		{
			this.current_limiting = true;
			if( !this.at_max_current )
			{
				// record voltages
				this.max_current_voltages = clone( this.battery.voltages )
				// pause charging
				// measure idle voltages at resume
				// calculate resistance from above voltages
				if( !this.resistances_estimated )
					this.pauseCharging()
				// this.pauseTimer = setTimeout( this.pauseCharging.bind(this), ChargeState.CHARGE_PERIOD_DURATION * 1000 )				
				this.at_max_current = true; // now if not earlier
				this.at_max_current_time = Date.now() / 1000.0

				return;
			}

			console.log( "Switching to current limiting mode")
		}

		const maxPowerIn = 230 * this.charger.max_wall_current // Watts, 10 amps in regular outlet
		const maxPowerOut = maxPowerIn * BoatModel.ChargerState.efficiency;
		const maxChargingCurrent = maxPowerOut * (1 - this.temperature_derating)/this.target_pack_voltage;
		// const maxChargingCurrent = maxPowerOut * (1 - this.temperature_derating)/this.charger.output_voltage;

		console.log( "max_wall_current=" + this.charger.max_wall_current + 
			", maxPowerIn=" + maxPowerIn + 
			", maxPowerOut=" + maxPowerOut + 
			", temperature_derating=" + this.temperature_derating +
			", maxChargingCurrent=" + maxChargingCurrent )

		if( !this.current_limiting )
		{
			console.log( "Not current limiting. charging current=" + this.charging_current + ", maxChargingCurrent=" + maxChargingCurrent )

			if( this.charging_current < maxChargingCurrent )
			{
				if( voltageDiff < 0.01 )
					this.charging_current += 0.1
				else
				{
					this.charging_current += 1
					console.log( "charging current increased by 1 A to " + this.charging_current )
				}

				if( this.charging_current > maxChargingCurrent )
				{
					this.charging_current = maxChargingCurrent
				}

				if( this.charging_current == maxChargingCurrent )
				{
					// todo: replicated code, move into function
					// record voltages
					this.max_current_voltages = clone( this.battery.voltages )
					// pause charging
					// measure idle voltages at resume
					// calculate resistance from above voltages
					if( !this.resistances_estimated )
						this.pauseCharging()
					// this.pauseTimer = setTimeout( this.pauseCharging.bind(this), ChargeState.CHARGE_PERIOD_DURATION * 1000 )				
					this.at_max_current = true; // now if not earlier
					this.at_max_current_time = Date.now() / 1000.0

					// console.log( "At max charging current" );
					// this.at_max_current = true;
					return;
				}
			}
			else
				this.charging_current = maxChargingCurrent
		}

		if( this.current_limiting )
		{
			if( this.charging_current <= BoatModel.ChargerState.MIN_CHARGING_CURRENT )
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
				if( voltageDiff <= 0.003 )
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
			", pack voltage=" + this.battery.getTotalVoltage()?.toFixed(1) + 
			" target voltage = " + this.target_pack_voltage.toFixed(1) + 
			" charging current = " + this.charging_current + 
			" max charging current=" + maxChargingCurrent.toFixed(1) +
			" at max current: " + this.at_max_current +
			" current_limiting: " + this.current_limiting );

		// assert( maxChargingCurrent < 40 );

		// record cell voltages before charging, so that we can estimate the 
		// internal resistance of the cell groups
		// the ... thing clonse the array
		this.charger!.setChargingParameters( this.target_pack_voltage, this.charging_current, true );
	}

	chargerChanged(): void
	{
		const charger = this.stateMachine.model.charger

		console.log( "Charge State: Charger changed, currently: " + charger.toString() )
		// assert( charger.canCharge() );

		if( charger.do_charge! )
		{
			this.latest_charging_current = charger.output_current!
			console.log( "ChargeState.chargerChanged: latest_charging_current=" + this.latest_charging_current )
		}
		if( !charger.canCharge() || charger!.output_voltage! > 75.6 || charger!.output_current! > 40 )
		{
			console.log( "Aborting charging due to charger" );
			this.abort();
		}
		// if charger settings (target SOC or max wall current) changed, call
		// recalculateCharging 
		if( (charger.max_wall_current != this.latest_max_wall_current) ||
		    (charger.target_soc != this.latest_target_soc))
		{
			this.latest_max_wall_current = this.model.charger.max_wall_current
			this.latest_target_soc = this.model.charger.target_soc
			this.recalculateCharging()
		}
	}

	abort(): void
	{
		this.charger!.setChargingParameters( 0, 0, false );

		console.log( "aborted charging, return to armed mode" );
		this.transitionTo( this.stateMachine.armedState );
	}

	done(): void
	{
		console.log( "Charging done, transitioning...");

		if( this.battery.isBalanced() )
			this.transitionTo( this.stateMachine.armedState );
		else
			this.transitionTo( this.stateMachine.balancingState );
	}

	batteryChanged(): void
	{
		const newTemperature = this.battery.getMaxTemperature()!
		const now = Date.now() / 1000

		if( newTemperature >= 35 )
		{
			console.log( "Aborting charging due to battery over temperature 35 C");
			this.abort();
			return;
		}

		console.log( "Charge State: Battery changed, currently: " + this.battery.toString() )

		// if the battery is not balanced, we need a re-charge after balancing anyway,
		// so we go to balancing when charge current has gone down to 5A 
		if( this.battery.getMaxCellVoltage()! >= (this.target_max_cell_voltage! - 0.002) && 
			((this.battery.isBalanced() && this.charging_current <= 0.5) ||
			 (!this.battery.isBalanced() && this.charging_current < 5)))
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

		if( this.is_paused )
			return;

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

			if( newTemperature < 31 && this.temperature_derating > 0.05 )
			    this.temperature_derating = 0.05;

			if( newTemperature < 32 && this.temperature_derating > 0.2 )
			    this.temperature_derating = 0.2;
		}
		else if( this.temperature_derating > 0.01 && 
                 newTemperature < 30 && 
                 this.temperature_change < 0 ) 
		{
			this.temperature_derating -= 0.01;
		}

		if( this.temperature_derating > 0.01 )
			console.log( "temperature derating (temp=" + newTemperature.toFixed(1) + " C, change=" + this.temperature_change.toFixed(2) + ": " +
				     (this.temperature_derating * 100).toFixed(0) + "%")

		this.recalculateCharging();
	}

	requestTransition( nextState: MJoulnirState ): boolean
	{
		console.log( "ChargeState: got transition request to " + nextState.name )
		switch( nextState )
		{
			case this.stateMachine.armedState:
				console.log( "ChargeState: setting armedState.pauseAutoCharge to true")
				this.stateMachine.armedState.pauseAutoCharge = true
				this.transitionTo( nextState )
				return true;

			default:
				return false;
		}
	}
}

class BalancingState extends MJoulnirState
{
	// 
	static readonly BALANCING_PASS_DURATION = 90

	readonly battery: BoatModel.Battery;
	readonly model: BoatModel.BoatModel;
	// readonly batteryReader: BatteryReader.BatteryReader;

	readonly boundBatteryListener: () => void;
	readonly boundChargerListener: () => void;
	// readonly boundStartBalancing: () => void;

	charger: BoatModel.ChargerState

	// initialWaitTimeout?: NodeJS.Timer;
	is_balancing = false;
	cellsToBalance: boolean[][] = [];
	initialVoltages: number[][] = [];
	targetVoltage = 0;
	balanceTimer?: NodeJS.Timer;
	settleTimer?: NodeJS.Timer;
	// settlingCount = 0

	constructor(machine: ElectricDrivetrainStateMachine)
	{
		super( BoatModel.State.Balancing, machine, "Balancing");

		this.model = machine.model;
		this.charger = this.model.charger
		this.battery = machine.model.battery;

		this.boundBatteryListener = this.batteryChanged.bind( this );
		this.boundChargerListener = this.chargerChanged.bind( this );
		// this.boundStartBalancing = this.startBalancing.bind( this );
	}

	canEnter(): boolean
	{
		// maybe deny if battery charge is too low
		// also TODO: stop balancing if any cell voltage is too low
		return true
	}

	enter( ): void 
	{
		super.enter();

		this.battery.onChanged( this.boundBatteryListener );
		this.charger.onChanged( this.boundChargerListener );

		// we don't need a high update interval, we poll the battery when required
		// this.stateMachine.batteryReader.setInterval( 60 );

		// TODO: monitor power switch
		// TODO: disable VESC? monitor VESC for going to active state

		this.model.vescState.setPollMCValueInterval( 2 );

		// first, wait one minute to let all cell voltages settle
		this.is_balancing = false;
		console.log( "Waiting one minute...");
		// temporarily changed to 10 seconds for testing
		// this.initialWaitTimeout = setTimeout( this.startBalancing.bind(this), /* 60 */ 10 * 1000 );
		this.finishBalancePass()
	}

	async startBalancingPass(): Promise<void>
	{
		this.cellsToBalance = this.calculateCellsToBalance();

		// Turn on balancing for all cells more than 5 mV above the lowest
		// cell
		this.battery.balance_cells( BalancingState.BALANCING_PASS_DURATION, this.cellsToBalance )
		// this.batteryReader.setBalanceTimer( BalancingState.BALANCING_PASS_DURATION )
		//	.then( () => this.batteryReader.balance( this.cellsToBalance ) )
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
		const voltages = this.battery.voltages;
		// const maxVoltage = this.batteryState.getMaxCellVoltage();
		const cellsToBalance: boolean[][] = [];
		const minVoltage = this.battery.getMinCellVoltage()!
		let counter = 0

		// if( Math.round(minVoltage * 1000) != Math.round(this.targetVoltage * 1000))
		if( minVoltage != this.targetVoltage)
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

				if( voltages[ moduleIndex ][ cellGroupIndex ] > (this.targetVoltage + BoatModel.Battery.BALANCE_THRESHOLD_V) )
				{
					doBalance = true;
					counter++;
				}
				else
					doBalance = false;

				cellsToBalance[ moduleIndex ][ cellGroupIndex ] = doBalance;
				if( cellGroupIndex > 0)
					line += ", ";

				const v = voltages[ moduleIndex ][ cellGroupIndex ]
				// console.log( "voltages[][]=" + v );
				line += v.toFixed(4) + (doBalance ? "*" : " ") + "V";
			}
			line += " ]";
			console.log( line );
		}

		console.log( "Balance count: " + counter )
		// this.printCellVoltages();
		this.printImbalance();

		return cellsToBalance;
	}

	finishBalancePass()
	{
		console.log( "Turning off balancing for evaluation")
		this.balanceTimer = undefined

		// turn off balancing
		this.battery.stopBalancing()
		/*
			.then( () => {
				console.log( "Waiting 20s for cells to settle")
				// this.settleTimer = setTimeout( this.observeSettling.bind(this), 1000 )
				this.observeSettling(10) 
			})
		*/
			.then( () => this.evaluateBalancing() )
			.catch( error => {
				console.log( "failed top stop balancing: " + error );
				console.log( error.stack );
				this.finishBalancePass(); // redo it.
			})
	}

	
	evaluateBalancing()
	{
		var line = "";
		var count = 0;

		this.settleTimer = undefined;

		console.log( "Eval: polling battery")

		this.battery.poll(true)
			.then( () => {
				if( this.battery.isBalanced() )
					this.done()
				else
				{
					const count = this.battery.voltages.reduce( (acc, cellVoltages) => cellVoltages.reduce( (acc, v) => {
						if( v > this.targetVoltage + BoatModel.Battery.BALANCE_MAX_DIFF_VOLTS)
						{
							console.log( "Balancing " + v.toFixed(5) + " V" );
							return acc + 1;
						}
						else
							return acc;
					}, acc), 0)

					console.log( "count=" + count)
					if( count > 0 )
						this.startBalancingPass();
					else
						this.done();
				}
			})
			.catch( (reason) => { console.log( "BalancingSate.evaluateBalancing: exception: " + reason ) } )
	}

	batteryChanged(): void
	{
		console.log( "Battery temperatures: " + 
			this.battery.getMinTemperature()!.toFixed(1) + " - "  + 
			this.battery.getMaxTemperature()!.toFixed(1) )
		
		// play it safe. 25 C may mean it is warmer somewhere inside the battery. 
		// Although it's probably the balancing resistors' dissipation that leaks
		// into the battery module
		if( this.battery.getMaxTemperature()! > 25 )
		{
			console.log( "Pausing balancing because battery temperature is over 25 C");
			this.transitionTo( this.stateMachine.armedState );
		}
	}

	printImbalance()
	{
		console.log( "Imbalance: " + this.battery.imbalance_V!.toFixed(5) + " V, " + 
					 (this.battery.imbalance_soc! * 100).toFixed(2) + "% soc")
	}

	printCellVoltages()
	{
		const allVoltages = this.battery.voltages;
		let line = "";

		for( let moduleIndex = 0; moduleIndex < allVoltages.length; moduleIndex++)
		{
			const voltages = allVoltages[ moduleIndex ];

			line = "[ ";
			for( let cellIndex = 0; cellIndex < voltages.length; cellIndex++ )
			{
				if( cellIndex != 0 )
					line += ", ";
				line += voltages[ cellIndex ].toFixed(4);
				if( voltages[cellIndex] > (this.targetVoltage + BoatModel.Battery.BALANCE_MAX_DIFF_VOLTS))
					line += "*"
			}
			line += " ]";
			console.log( line )
		}
	}

	done(): void
	{
		// this.stateMachine.chargeState.target_soc = 0.8;
		// this.stateMachine.chargeState.setParameters( 0.8, ArmedState.MAX_WALL_CURRENT );
		this.transitionTo( this.stateMachine.chargeState );
	}

	abort(): void
	{
		this.transitionTo( this.stateMachine.armedState );
	}

	exit( ): void
	{
		super.exit()
		// TODO: turn off all balancing
	
		if( !(this.balanceTimer === undefined) )
		{
			clearTimeout( this.balanceTimer )
			this.balanceTimer = undefined;
		}

		this.stateMachine.model.charger.unOnChanged( this.boundChargerListener );
		if( this.is_balancing )
			this.stateMachine.model.battery.unOnChanged( this.boundBatteryListener )

		this.model.vescState.setPollMCValueInterval( 0 );

		this.is_balancing = false;
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

	// vesc?: VESC.VESCtalker;
	// charger?: Charger.ELCONCharger;
	// readonly batteryReader: BatteryReader.BatteryReader;

	readonly model: BoatModel.BoatModel;
	readonly battery: BoatModel.Battery

	readonly idleState = new IdleState(this);
	readonly batteryErrorState = new BatteryErrorState(this);
	readonly turnOnContactorState = new TurnOnContactorState(this);	
	readonly armedState: ArmedState
	readonly activeState
	readonly chargeState
	readonly balancingState

	constructor( model: BoatModel.BoatModel )
	{
		super();
		this.model = model;

		this.battery = model.battery;
		// these must be created after the state machine's model is assigned
		this.armedState = new ArmedState(this);
		this.activeState = new ActiveState(this);
		this.chargeState = new ChargeState(this);

		// balancingState must be created after the batteryReader
		this.balancingState = new BalancingState(this);

		this.state = this.idleState;
	}

	start( ): void
	{
		this.battery.poll(true)
			.then( () => {
				console.log( "Imbalance: " + this.model.battery.imbalance_V!.toFixed(3) + " V, " +
					(this.battery.imbalance_soc! * 100).toFixed(1) + "% soc" )
			})
			.catch( (error) => {
				console.log( "Failed to start battery reader: " + error );
				console.log( "Stack: " + error.stack ); // check battery once a minute
			})

		this.state.enter();
	}

	requestTransition( modelState: BoatModel.State ): boolean
	{
		let state: MJoulnirState

		console.log( "ElectricDrivetrainStateMachine.requestTransition(" + modelState.toString() + ")")

		switch( modelState )
		{
			case BoatModel.State.Idle:
				state = this.idleState
				break;

			case BoatModel.State.Armed:
				state = this.armedState
				break;

			case BoatModel.State.Arming:
				state = this.turnOnContactorState
				break

			case BoatModel.State.Charging:
				state = this.chargeState
				break;

			case BoatModel.State.Balancing:
				state = this.balancingState
				break;

			case BoatModel.State.Off:
			case BoatModel.State.Active:
			case BoatModel.State.Error:
				return false;
		}

		console.log( "ElectricDrivetrainStateMachine.requestTransition: Calling canEnter on " + state.name)
		if( !state.canEnter() )
		{
			console.log( "Can't enter state " + state.name );
			return false;
		}
		else
			console.log( "Requesting transition from " + this.state.name + " to " + state.name );

		return this.state.requestTransition( state )
	}

	transitionTo( state: MJoulnirState ): void
	{
		console.log( "Transitioning to state " + state.name );

		this.state = state;
		return this.state.enter();
	}
}
