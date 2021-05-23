import * as VESCble from 'vesc-ble'
import * as VESCreader from "./vesc"

import * as BoatModel from "./boatModel"
import * as BLECentral from './bleCentral';
import * as StateMachine from './stateMachine';
import { TeslaBatteryReader } from "./batteryReader";
// import { VESCtalker } from "./vesc";
import * as RaspiHardware from "./raspiHardware";
import { ELCONCharger } from './elconCharger';

async function delay(seconds: number)
{
	return new Promise<void>( resolve => setTimeout( resolve, seconds * 1000 ) );
}	

const batteryReader = new TeslaBatteryReader("/dev/serial0")
const bleVESC = new VESCble.VESC()
const hardware = new RaspiHardware.RaspiHardware()
const vescTalker = new VESCreader.VESCtalker(bleVESC) // bleVESC: VESCble.VESCinterface
const charger = new ELCONCharger(vescTalker)
const boatModel = new BoatModel.BoatModel(batteryReader, vescTalker, hardware, charger )

boatModel.battery.onChanged( () => {
	console.log( "Battery: SOC=" + (boatModel.battery.soc_from_min_voltage() * 100).toFixed(0) + "%, " + 
		"voltage: " + boatModel.battery.getTotalVoltage()?.toFixed(1) + " V, " +
		"min cell voltage= " + boatModel.battery.getMinCellVoltage()?.toFixed(3) + " V ");
});

const statemachine = new StateMachine.ElectricDrivetrainStateMachine( boatModel );

boatModel.start()
	.then( () => statemachine.start() )

// BLE startup too early will fail because BLE device not available.
delay( 10 )
	.then( () => { console.log( "Starting BLE Central" );
                   BLECentral.start(boatModel, statemachine) 
	});


/*
function stop()
{
	batteryReader!.stop();
	batteryReader!.close();

	BLECentral.stop();

	// BLECentral.stop(); TODO
	console.log( "Done!" );
}
*/
function waitForAdv2( resolve: () => void )
{
	if( BLECentral.isAdvertising )
		resolve();
	else
		setTimeout( waitForAdv2, 1000, resolve );
}

async function waitForAdvertising(): Promise<void>
{
	return new Promise( (resolve, reject) => waitForAdv2( resolve ) );
}
