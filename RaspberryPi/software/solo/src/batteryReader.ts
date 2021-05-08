import * as BMS from 'tesla-slave-bms';
import * as events from 'events';

let cancel = false;
let cancelled = false;

export interface UpdateData {
	voltages: number[][],
	temperatures: number[][],
	fault: boolean,
	alert: boolean,
	update_imbalance: boolean
}

export interface BatteryReader extends events.EventEmitter
{
	close(): void
	start( intervalSeconds: number): Promise<void>
	setBalanceTimer( seconds: number ): Promise<void>
	balance( cells: boolean[][]): Promise<void>
	stopBalancing(): Promise<void>

	stop(): void

	setInterval( newInterval: number ): void

	poll(update_imbalance: boolean): Promise<void>

	update(): Promise<void>
}

export class TeslaBatteryReader extends events.EventEmitter implements BatteryReader 
{
	batteryPack: BMS.BMSPack;
	timeout?: number /* NodeJS.Timer */;
	intervalSeconds?: number; // just some value before started to make TS happy 
	retry_count = 0;

	cancel = false;
	cancelPromise?: Promise<void>;
	update_imbalance = false

	constructor( serialPortName: string)
	{
		super()
		this.batteryPack = new BMS.BMSPack( serialPortName );
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
			.catch( (error) => console.log( "Error starting battery reader: " + error ))
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
		clearTimeout( this.timeout! );
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

				const voltagesArray: number[][] = []
				const temperaturesArray: number[][] = []
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

				const data: UpdateData = {
					voltages: voltagesArray,
					temperatures: temperaturesArray,
					fault: this.batteryPack.hasFault(),
					alert: this.batteryPack.hasAlert(),
					update_imbalance: this.update_imbalance
				}

				this.emit('update', data );

				let boundFunc =  updateReader.bind(this)
				this.timeout = setTimeout( boundFunc, 1000 ) // this.intervalSeconds! * 
			} )
			.catch( (error) => { 
				this.retry_count++;
				console.log("batteryReader.update: readAll failed: " + error + ", retrying (" + this.retry_count + "th time)" );  
				// todo: add retry counts
				return this.update();
			} )
	}
}

function updateReader( reader: BatteryReader )
{
	reader.update();
}
