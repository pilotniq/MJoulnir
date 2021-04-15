import * as BoatModel from "./boatModel"
import * as BLECentral from './bleCentral';
import * as StateMachine from './stateMachine';
	
async function delay(seconds: number)
{
	return new Promise<void>( resolve => setTimeout( resolve, seconds * 1000 ) );
}	

BoatModel.boatModel.batteryState.onChanged( () => {
	console.log( "Battery: SOC=" + (BoatModel.boatModel.batteryState.soc_from_min_voltage() * 100).toFixed(0) + "%, " + 
		"voltage: " + BoatModel.boatModel.batteryState.getTotalVoltage()?.toFixed(1) + " V, " +
		"min cell voltage= " + BoatModel.boatModel.batteryState.getMinCellVoltage()?.toFixed(3) + " V ");
});

const statemachine = new StateMachine.ElectricDrivetrainStateMachine( BoatModel.boatModel,
	"/dev/serial0" );

statemachine.start();
BLECentral.start(BoatModel.boatModel);

/*
let batteryReader: BatteryReader.BatteryReader | undefined = undefined;
// let vescReader: VESC.VESCtalker;

function start()
{

	batteryReader = new BatteryReader.BatteryReader( "/dev/serial0", BoatModel.boatModel);
	batteryReader.start(60); // check battery once a minute

	// while( !BLECentral.isAdvertising )

	// vescReader = new VESC.VESCtalker( BoatModel.boatModel );
	StateMachine.start(BoatModel.boatModel);
}
*/
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


// waitForAdvertising().then( () => start() );
