import * as Model from "./model"
import * as BoatModel from "./boatModel"
import * as Bleno from '@abandonware/bleno'
import { ElectricDrivetrainStateMachine } from "./stateMachine"

const UUID_DESCRIPTOR_CCCD = '2904'
const UUID_DESCRIPTOR_CHARACTERISTIC_USER_DESCRIPTION = '2901'

const UUID_SERVICE_BATTERY = '180f';
const UUID_CHARACTERISTIC_BATTERY_LEVEL = '2a19';

const UUID_SERVICE_ELECTRIC_DRIVETRAIN = '71498776a04c4800a1d925ebc70b0000';
const UUID_CHARACTERISTIC_BATTERY_VOLTAGES = '71498776a04c4800a1d925ebc70b0001';
const UUID_CHARACTERISTIC_STATE = '71498776a04c4800a1d925ebc70b0002';
const UUID_CHARACTERISTIC_BATTERY_IMBALANCE = '71498776a04c4800a1d925ebc70b0003';
const UUID_CHARACTERISTIC_TEMPERATURES = '71498776a04c4800a1d925ebc70b0004';
const UUID_CHARACTERISTIC_POWER = '71498776a04c4800a1d925ebc70b0005';

let blenoOn = false;
let started = false;


abstract class BoatModelCharacteristic extends Bleno.Characteristic
{
	readonly model: BoatModel.BoatModel;
	readonly modelAttribute: Model.ModelAttribute;
	readonly name: string

	value!: Buffer;
	updateValueCallback: ((data: Buffer) => void) | undefined = undefined;
	maxValueSize: number | undefined = undefined;

	constructor( model: BoatModel.BoatModel, attribute: Model.ModelAttribute, 
		characteristicUUID: string, name: string, writable=false )
	{
		super({
			uuid: characteristicUUID,
			properties: writable ? ['read', 'write', 'notify'] : ['read', 'notify'],
				descriptors: [
				  new Bleno.Descriptor({
					uuid: UUID_DESCRIPTOR_CHARACTERISTIC_USER_DESCRIPTION,
					value: name
				  }),
				  new Bleno.Descriptor({
					uuid: UUID_DESCRIPTOR_CCCD,
					value: Buffer.from([0x01, 0x00])
				  })
				]
			}); // end of super call
		this.model = model;
		this.name = name
		this.modelAttribute = attribute;
		this.modelAttribute.onChanged( this.updateValue.bind(this) );
	}

	onSubscribe( maxValueSize: number, updateValueCallback: (data: Buffer) => void) {
		console.log( "onSubscribe!" );
		this.updateValueCallback = updateValueCallback;
		this.maxValueSize = maxValueSize;
	}

	onUnsubscribe( /* x: () => void */ ) {
		console.log( "onUnsubscribe" );
		this.updateValueCallback = undefined;
	}

	onReadRequest(offset: number, callback: (error_code: number, data?: Buffer) => void )
	{
		console.log( "BoatModelCharacteristic.onReadRequest")
		callback(Bleno.Characteristic.RESULT_SUCCESS, this.value);
	}

	// Update the value Buffer 
	abstract buildValue(): void

	updateValue() {
		console.log( "BoatModelCharacteristic.updateValue entry for " + this.name )
		const oldValue = Buffer.from( this.value )

		this.buildValue();

		if( !oldValue.equals( this.value ) && this.updateValueCallback )
		{
			// console.log( "Calling updateValueCallback" );
			this.updateValueCallback( this.value );
		}
		else
			console.log( "Attribute " + this.name + ", update called but not changed" )
		// console.log( "BoatModelCharacteristic.updateValue exit")
	}
}

abstract class WritableBoatModelCharacteristic extends BoatModelCharacteristic
{
	constructor( model: BoatModel.BoatModel, attribute: Model.ModelAttribute, 
		characteristicUUID: string, name: string )
		{
			super( model, attribute, characteristicUUID, name, true )
		}

	abstract onWriteRequest(data: Buffer, offset: number, withoutResponse: boolean, callback: (error_code: number) => void ): void
		// callback(Bleno.Characteristic.RESULT_SUCCESS, this.value);
}

class BatteryLevelCharacteristic extends BoatModelCharacteristic
{
	constructor(model: BoatModel.BoatModel) {
		super( model, model.battery, UUID_CHARACTERISTIC_BATTERY_LEVEL, "Battery level" );
  
		this.buildValue();
	}
	
	buildValue()
	{
		let battery = this.model.battery;

		this.value = Buffer.alloc(1);

		const soc = battery.soc_from_min_voltage()
		// TODO: Improve soc estimate from battery
		this.value[0] = Math.round( soc * 100 )
		console.log( "Battery Level: soc=" + soc + " this.value[0]=" + this.value[0] );
	}
}

/*
  The battery voltages consists of an array of voltages.
  Voltages are two bytes. High byte is volts, and low byte is fractions (1/256 volt)

  index 0 is the total battery voltage
  index 1 is one byte with the number of modules
  index 2,3,4 is the voltage of modules 1,2,3

  index 2 is one byte with the number of cells in each module

  index 4-9 are the voltages of the cells of module 1
  index 10-15 are the voltages of the cells of module 2
  index 
*/
class BatteryVoltagesCharacteristic extends BoatModelCharacteristic
{
	constructor(model: BoatModel.BoatModel) {
	  super( model, model.battery, UUID_CHARACTERISTIC_BATTERY_VOLTAGES, "Battery voltages" );

	  this.buildValue();
	}

	/* The value consists of:
	  two bytes little endian totalVoltage: (total voltage - 15) * 1000
	  18 bytes for cell voltages. Each byte is round((voltage - 2) * 100)
	*/
	buildValue() {
	  let batteryState = this.model.battery;
	  let voltages = batteryState.voltages;
	  let moduleCount = voltages.length;

	  if( moduleCount == 0 )
	    this.value = Buffer.alloc(0);
	  else
	  {
	    let cellCount = voltages[0].length; // number of cells per module
	    let cellVoltageCount = moduleCount * voltages[0].length;

	    // todo: adadpt to maxValueSize
	    this.value = Buffer.alloc(cellVoltageCount + 2);
	    let totalVoltageValue = Math.round( (batteryState.getTotalVoltage()! - 15.0) * 1000);
	    this.value[0] = totalVoltageValue & 0xff;
	    this.value[1] = (totalVoltageValue >> 8) & 0xff;
	    
	    let i = 2;

	    for( let m = 0; m < moduleCount; m++ )
		for( let c = 0; c < cellCount; c++, i++ )
			this.value[i] = Math.round((voltages[m][c] - 2) * 100);
	  }
	}

	onReadRequest(offset: number, callback: (result: number, data?: Buffer) => void) {
	  if (offset) {
	    callback(this.RESULT_ATTR_NOT_LONG, undefined);
	  }
	  else {
	    // var data = Buffer.alloc(1);
	    // data.writeUInt8(42, 0); // replace 42 with the actual voltage values
	    callback(this.RESULT_SUCCESS, this.value);
	  }
	}
}

class TemperaturesCharacteristic extends BoatModelCharacteristic
{
	readonly vescState
	readonly batteryState

	constructor(model: BoatModel.BoatModel) {
	  super( model, model.battery, UUID_CHARACTERISTIC_TEMPERATURES, "Temperatures" );

	  this.vescState = model.vescState
	  this.batteryState = model.battery

	  // base class will subscribe to model.batteryState
	  model.vescState.onChanged( this.updateValue.bind(this) )

	  this.buildValue();
	}

	/* The value consists of:
		Each temperature is one byte, signed integer
		0x80 means invalid

		Temperatures are:
		VESC: temp_mos;
	          temp_mos_1;
	 	      temp_mos_2;
		      temp_mos_3;
		      temp_motor;
		Batteries: 6 temperatures (2 for each module)
		Raspberry Pi

		Total: 12 bytes
	*/
	buildValue() {
		this.value = Buffer.alloc(12);

		if( this.vescState.isValid )
		{
			this.value[0] = Math.round(this.vescState.temp_mos)
			this.value[1] = Math.round(this.vescState.temp_mos_1)
			this.value[2] = Math.round(this.vescState.temp_mos_2)
			this.value[3] = Math.round(this.vescState.temp_mos_3)
			this.value[4] = Math.round(this.vescState.temp_motor)
		}
		else
		{
			console.log( "TemperaturesCharacteristic.buildValue: vescState is invalid");
			
			this.value[0] = 0x80;
			this.value[1] = 0x80;
			this.value[2] = 0x80;
			this.value[3] = 0x80;
			this.value[4] = 0x80;
		}

		if( this.batteryState.isValid )
		{
			for( let i = 0; i < this.batteryState.temperatures.length; i++ )
				for( let j = 0; j < this.batteryState.temperatures[i].length; j++ )
				{
					const valueIndex = 5 + i * this.batteryState.temperatures[i].length + j
					this.value[valueIndex] = Math.round(this.batteryState.temperatures[i][j])
				}
		}
		else
			console.log( "TemperaturesCharacteristic.buildValue: batteryState invalid" );

		this.value[11] = 0x80; // raspberry pi not implmented yet
	}
}

class StateCharacteristic extends WritableBoatModelCharacteristic
{
	readonly stateMachine: ElectricDrivetrainStateMachine

	constructor(model: BoatModel.BoatModel, stateMachine: ElectricDrivetrainStateMachine) {
		super( model, model.state, UUID_CHARACTERISTIC_STATE, "State" );

		this.stateMachine = stateMachine
		this.value = Buffer.alloc(2);
		this.buildValue()
		this.model.state.onChanged( this.updateValue.bind(this) );
	}

	onWriteRequest(data: Buffer, offset: number, without_response: boolean, 
		callback: (error_code: number) => void )
	{
		const newStateRaw = data[0]

		console.log( "BoatModelCharacteristic.onWriteRequest")

		if( newStateRaw > BoatModel.State.Active )
			callback( Bleno.Characteristic.RESULT_UNLIKELY_ERROR)
		else
		{
			const newState :BoatModel.State =newStateRaw!
			
			this.stateMachine.requestTransition( newState as BoatModel.State )
			callback(Bleno.Characteristic.RESULT_SUCCESS);
		}
	}

	updateValue()
	{
		console.log( "StateCharacteristic: updateValue()")
		console.trace()
		super.updateValue()
	}

	buildValue()
	{
		this.value[0] = this.model.state.state
	}
}

class BatteryBalanceCharacteristic extends BoatModelCharacteristic
{
	readonly batteryState: BoatModel.Battery

	// value is 4 bytes:
	// First two is imbalance in mV
	// second two is imbalance in % SOC * 100
	constructor(model: BoatModel.BoatModel) {
		super( model, model.state, UUID_CHARACTERISTIC_BATTERY_IMBALANCE, "Battery Imbalance" );

		this.value = Buffer.alloc(4);
		this.batteryState = this.model.battery
		this.batteryState.onChanged( this.updateValue.bind(this) );
	}

	buildValue()
	{
		let mv = Math.round(this.batteryState.imbalance_V! * 1000)
		let percentx10 = Math.round(this.batteryState.imbalance_soc! * 100 * 100)

		this.value[0] = mv & 0xff
		this.value[1] = (mv >> 8 & 0xff)
		this.value[2] = percentx10 & 0xff;
		this.value[3] = (percentx10 >> 8) & 0xff
	}
}

class PowerCharacteristic extends BoatModelCharacteristic
{
	readonly battery: BoatModel.Battery
	readonly vesc: BoatModel.VESC

	// value is 4 bytes:
	// First two is signed battery power flow in W (range +-32kW). 
	// Negative when power is consumed, positive when charging
	// next is two bytes is battery current (signed, current * 100)
	// next two bytes is accumulated Wh consumed
	// next byte is ESC duty cycle
	constructor(model: BoatModel.BoatModel) {
		super( model, model.state, UUID_CHARACTERISTIC_POWER, "Power" );

		this.value = Buffer.alloc(9);
		this.vesc = this.model.vescState
		this.battery = this.model.battery
		this.vesc.onChanged( this.updateValue.bind(this) );
		this.battery.onChanged( this.updateValue.bind(this) );
	}

	buildValue()
	{
		let power = this.battery.estimated_power
		let currentx10 = Math.round(this.battery.current * 100)
		// convert J to Wh
		let dEnergy = Math.round(this.battery.estimated_energy_change / 3600)

		this.value[0] = power & 0xff
		this.value[1] = (power >> 8 & 0xff)

		this.value[2] = currentx10 & 0xff;
		this.value[3] = (currentx10 >> 8) & 0xff

		this.value[4] = dEnergy & 0xff;
		this.value[5] = (dEnergy >> 8) & 0xff

		this.value[6] = this.vesc.rpm & 0xff
		this.value[7] = (this.vesc.rpm >> 8) & 0xff

		this.value[8] = Math.round(this.vesc.duty_now * 100)

		console.log( "PowerCharacteristic.buildValue called. duty_now=" + this.vesc.duty_now)
	}
}

class ElectricDrivetrainService extends Bleno.PrimaryService {
	constructor( model: BoatModel.BoatModel, stateMachine: ElectricDrivetrainStateMachine)
	{
	  super( {
	      uuid: UUID_SERVICE_ELECTRIC_DRIVETRAIN,
      	      characteristics: [
              	new BatteryVoltagesCharacteristic(model),
				new StateCharacteristic(model, stateMachine),
				new BatteryBalanceCharacteristic(model),
				new TemperaturesCharacteristic(model),
		new PowerCharacteristic(model)
      	      ]
  	  });
	}
}

class BatteryService extends Bleno.PrimaryService {
	constructor( model: BoatModel.BoatModel )
	{
	  super( {
	      uuid: UUID_SERVICE_BATTERY,
      	  characteristics: [ new BatteryLevelCharacteristic(model) ]
  	  });
	}
}

let electricDrivetrainService: ElectricDrivetrainService | undefined = undefined
let batteryService: BatteryService | undefined = undefined

export function start( model: BoatModel.BoatModel, stateMachine: ElectricDrivetrainStateMachine): void
{
    electricDrivetrainService = new ElectricDrivetrainService(model, stateMachine);
	batteryService = new BatteryService(model);

  //
  // Wait until the BLE radio powers on before attempting to advertise.
  // If you don't have a BLE radio, then it will never power on!
  //
  // DOing bleno.on inits HCI stack which may fail if BT is not initialized.
  // moved into start function to be able to delay startup
  //
  Bleno.bleno.on('stateChange', function(state) {
    if (state === 'poweredOn') {
	blenoOn = true;
	if( started )
		startAdvertising();
    }
    else 
    {
      console.log( "bleno stateChage => " + state );

      Bleno.bleno.stopAdvertising();
    }
  });

  Bleno.bleno.on('advertisingStart', function(err) {
    if (!err) {
      console.log('advertising...');
      //
      // Once we are advertising, it's time to set up our services,
      // along with our characteristics.
      //
      Bleno.bleno.setServices([electricDrivetrainService!, batteryService!]);
    }
  });


	if( blenoOn )
		startAdvertising();

	started = true;	
}

export function stop(): void
{
	Bleno.bleno.stopAdvertising()
}

export let isAdvertising = false;

function startAdvertising()
{
    //
    // We will also advertise the service ID in the advertising packet,
    // so it's easier to find.
    //

    Bleno.bleno.startAdvertising("Solo", [electricDrivetrainService!.uuid, batteryService!.uuid], function(err) {
      if (err) {
        console.log("Bleno advertising error: " + err);
      }
	  isAdvertising = true;
    });
}
