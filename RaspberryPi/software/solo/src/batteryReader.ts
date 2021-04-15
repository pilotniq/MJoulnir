import * as BoatModel from "./boatModel"
// import * as Model from './model';
import * as BMS from 'tesla-slave-bms';

let cancel = false;
let cancelled = false;

export class BatteryReader
{
	batteryPack: BMS.BMSPack;
	model: BoatModel.BoatModel;
	batteryState: BoatModel.BatteryState
	timeout?: number;
	intervalSeconds?: number; // just some value before started to make TS happy 
	retry_count = 0;

	cancel = false;
	cancelPromise?: Promise<void>;
	update_imbalance = false

	constructor( serialPortName: string, _model: BoatModel.BoatModel )
	{
		this.batteryPack = new BMS.BMSPack( serialPortName );
		this.model = _model;
		this.batteryState = _model.batteryState
	}

	close(): void
	{
		this.batteryPack.close();
	}

	async start( intervalSeconds: number): Promise<void>
	{
		this.intervalSeconds = intervalSeconds;

		console.log( "batteryReader.start");
		return this.batteryPack.init()
			.then( () => this.batteryPack.wakeBoards() )
			.then( () => this.setInterval( intervalSeconds ))
	}

	async setBalanceTimer( seconds: number ): Promise<void>
	{
		return this.batteryPack.setBalanceTimer( seconds );
	}

	async balance( cells: boolean[][]): Promise<void>
	{
		let indexCounter = 0;
		const transformedCells: boolean[][] = [];

		Object.keys(this.batteryPack.modules).sort().forEach( key => {
			transformedCells[ key as unknown as number ] = cells[ indexCounter ];
			indexCounter++;
		});

		return this.batteryPack.balance( transformedCells );
	}

	async stopBalancing(): Promise<void>
	{
		return this.batteryPack.stopBalancing();
	}

	stop(): void
	{
		clearTimeout( this.timeout );
		this.timeout = undefined;
	}

	public setInterval( newInterval: number ): void
	{
		if( !(this.timeout === undefined) )
			clearTimeout( this.timeout );

		this.intervalSeconds = newInterval;
		this.update();
	}

	public async poll(update_imbalance: boolean): Promise<void>
	{
		if( this.timeout )
			clearTimeout( this.timeout );

		this.update_imbalance = update_imbalance

		return this.update();
	}

	public async update(): Promise<void>
	{
		return this.batteryPack.readAll()
			.then( () => {
				this.retry_count = 0;
				let moduleIndex = 0;
				const voltagesArray = this.model.batteryState.voltages;
				const temperaturesArray = this.model.batteryState.temperatures;

				Object.keys(this.batteryPack.modules).sort().forEach( key => { 
					if( voltagesArray.length <= moduleIndex )
						voltagesArray.push( this.batteryPack.modules[Number(key)].cellVoltages );
					else
						voltagesArray[moduleIndex] = this.batteryPack.modules[Number(key)].cellVoltages;
					
					if( temperaturesArray.length <= moduleIndex )
						temperaturesArray.push( this.batteryPack.modules[Number(key)].temperatures );
					else
						temperaturesArray[moduleIndex] = this.batteryPack.modules[Number(key)].temperatures;
					moduleIndex++;
				});

				// console.log( "BatteryReader: new voltages=" + JSON.stringify( this.batteryPack.modules ));
				// console.log( "BatteryReader: model voltages=" + JSON.stringify( voltagesArray ));
				this.batteryState.fault = this.batteryPack.hasFault();
				this.batteryState.alert = this.batteryPack.hasAlert();

				this.batteryState.isValid = true;

				if( this.update_imbalance )
				{
					this.batteryState.updateImbalance()
					this.update_imbalance = false
				}
				this.batteryState.signalUpdated();
				this.timeout = setTimeout( updateReader, this.intervalSeconds! * 1000, this );
			} )
			.catch( (error) => { 
				this.retry_count++;
				console.log("batteryReader.update: readAll failed: " + error + ", retrying (" + this.retry_count + "th time)" );  
				// todo: add retry counts
				return this.update();
			} )
	}
}

async function updateReader( reader: BatteryReader )
{
	return reader.update();
}
