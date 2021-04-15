// export as namespace teslaSlaveBMS;

/*
export class BMSPack {
	constructor( serialDevice: string );
	init(): number;
}
*/
declare module 'tesla-slave-bms' {
	export declare class BMSBoard {
		id: number;
		cellVoltages: number[];
		temperatures: number[];
	}

	// export = BMSPack;
	export declare class BMSPack {
		modules: { [num: number]: BMSBoard };
		constructor( serialDevice: string );
		init(): Promise<void>;
		close();
		findBoards(): Promise<void>;
		wakeBoards(): Promise<void>;
		sleep(): Promise<void>;
		hasAlert(): boolean;
		hasFault(): boolean;
		setBalanceTimer( seconds: number ): Promise<void>
		balance( cells: boolean[][] ): Promise<void>
		stopBalancing(): Promise<void>
		readAll(): Promise<void>;
		getMinVoltage(): number;
		getMaxTemperature(): number;
	}
}
/*
declare class BMSPack {
		init(); number; // Promise<any>;
}
*/
/*
declare module 'tesla-slave-bms' {
	export class BMSBoard {};

	export class BMSPack {
		// modules: BMSBoard[];

		// constructor( serialDevice: string );
		init(); Promise<any>;
*
		close();
		findBoards(): Promise<void>;
		wakeBoards(): Promise<void>;
		sleep(): Promise<void>;
		hasAlert(): boolean;
		hasFault(): boolean;
		readAll(): Promise<void>;
/
	}
}
*/
