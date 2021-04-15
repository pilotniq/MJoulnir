import * as Model from "./model"
import * as BoatModel from "./boatModel"
import * as Bleno from '@abandonware/bleno'
// import PrimaryService from '@abandonware/bleno'
// import Characteristic from '@abandonware/bleno'

// var util = require('util');
// var bleno = require('@abandonware/bleno');

let UUID_DESCRIPTOR_CCCD = '2904'
let UUID_DESCRIPTOR_CHARACTERISTIC_USER_DESCRIPTION = '2901'

let UUID_SERVICE_ELECTRIC_DRIVETRAIN = '71498776a04c4800a1d925ebc70b0000';
let UUID_CHARACTERISTIC_BATTERY_VOLTAGES = '71498776a04c4800a1d925ebc70b0001';
let UUID_CHARACTERISTIC_STATE = '71498776a04c4800a1d925ebc70b0002';
let UUID_CHARACTERISTIC_BATTERY_IMBALANCE = '71498776a04c4800a1d925ebc70b0003';

let blenoOn = false;
let started = false;
let model: BoatModel.BoatModel | undefined;

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

// console.log( "Bleno: " + typeof Bleno );
// console.log( "Bleno keys: " + Object.keys( Bleno ) );
// console.log( "PS type: " + typeof Bleno.Bleno.Characteristic );

abstract class BoatModelCharacteristic extends Bleno.Characteristic
{
	readonly model: BoatModel.BoatModel;
	readonly modelAttribute: Model.ModelAttribute;

	value!: Buffer;
	updateValueCallback: ((data: Buffer) => void) | undefined = undefined;
	maxValueSize: number | undefined = undefined;

	constructor( model: BoatModel.BoatModel, attribute: Model.ModelAttribute, 
		characteristicUUID: string, name: string )
	{
		super({
			uuid: characteristicUUID,
			properties: ['read', 'notify'],
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

	onReadRequest(offset: number, callback: (error_code: number, data?: Buffer | undefined) => void )
	{
		callback(Bleno.Characteristic.RESULT_SUCCESS, this.value);
	}

	// Update the value Buffer 
	abstract buildValue(): void

	updateValue() {
		const oldValue = Buffer.from( this.value )

		this.buildValue();

		if( !oldValue.equals( this.value ) && this.updateValueCallback )
		{
			console.log( "Calling updateValueCallback" );
			this.updateValueCallback( this.value );
		}
	}
}
class BatteryVoltagesCharacteristic extends BoatModelCharacteristic
{
	constructor(model: BoatModel.BoatModel) {
	  super( model, model.batteryState, UUID_CHARACTERISTIC_BATTERY_VOLTAGES, "Battery voltages" );

	  this.buildValue();
	}

	/* The value consists of:
	  two bytes little endian totalVoltage: (total voltage - 15) * 1000
	  18 bytes for cell voltages. Each byte is round((voltage - 2) * 100)
	*/
	buildValue() {
	  let batteryState = this.model.batteryState;
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

class StateCharacteristic extends BoatModelCharacteristic
{
	// value!: Buffer;
	// updateValueCallback: ((data: Buffer) => void) | undefined = undefined;

	constructor(model: BoatModel.BoatModel) {
		super( model, model.state, UUID_CHARACTERISTIC_STATE, "State" );

		this.value = Buffer.alloc(2);
		this.model.state.onChanged( this.updateValue.bind(this) );
	}

	buildValue()
	{
		this.value[0] = this.model.state.state
	}
}

class BatteryBalanceCharacteristic extends BoatModelCharacteristic
{
	readonly batteryState: BoatModel.BatteryState

	// value is 4 bytes:
	// First two is imbalance in mV
	// second two is imbalance in % SOC * 100
	constructor(model: BoatModel.BoatModel) {
		super( model, model.state, UUID_CHARACTERISTIC_BATTERY_IMBALANCE, "Battery Imbalance" );

		this.value = Buffer.alloc(4);
		this.batteryState = this.model.batteryState
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
// util.inherits(BatteryVoltagesCharacteristic, bleno.Characteristic);


// var BatteryVoltageCharacteristic = require('./battery-level-characteristic');

// console.log( "Bleno: " + typeof Bleno );
// console.log( "Bleno keys: " + Object.keys( Bleno ) );
// console.log( "PS type: " + typeof Bleno.PrimaryService );

class ElectricDrivetrainService extends Bleno.PrimaryService {
	constructor( model: BoatModel.BoatModel)
	{
	  super( {
	      uuid: UUID_SERVICE_ELECTRIC_DRIVETRAIN,
      	      characteristics: [
              	new BatteryVoltagesCharacteristic(model),
				new StateCharacteristic(model),
				new BatteryBalanceCharacteristic(model)
      	      ]
  	  });
	}
}

// util.inherits(ElectricDrivetrainService, bleno.PrimaryService);

// service = new 
// console.log( "eds.uuid=" + eds );
//
// Wait until the BLE radio powers on before attempting to advertise.
// If you don't have a BLE radio, then it will never power on!
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

let electricDrivetrainService: ElectricDrivetrainService | undefined = undefined

Bleno.bleno.on('advertisingStart', function(err) {
  if (!err) {
    console.log('advertising...');
    //
    // Once we are advertising, it's time to set up our services,
    // along with our characteristics.
    //
    Bleno.bleno.setServices([electricDrivetrainService!]);
  }
});

export function start( _model: BoatModel.BoatModel): void
{
	model = _model;

    electricDrivetrainService = new ElectricDrivetrainService(model!);

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

    Bleno.bleno.startAdvertising("Solo", [electricDrivetrainService!.uuid], function(err) {
      if (err) {
        console.log("Bleno advertising error: " + err);
      }
	  isAdvertising = true;
    });
}

