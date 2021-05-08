import * as events from 'events';
import rfdc from "rfdc";

import * as VESCble from 'vesc-ble'
import vescBle from 'vesc-ble';

import * as BatteryReader from './batteryReader';

const clone = rfdc();

export class SimulatedBatteryReader extends events.EventEmitter implements BatteryReader.BatteryReader
{
    intervalSeconds?: number; // just some value before started to make TS happy 
    update_imbalance = false
    timeout?: NodeJS.Timer // ?? Why doesn't NodeJS.Timer work? */

    voltages: number[][]
    temperatures: number[][]
    hasFault = false
    hasAlert = false
    
    
    constructor()
    {
        super()
        this.voltages = [ [ 3.7, 3.7, 3.7, 3.7, 3.7, 3.7 ],
                     [ 3.7, 3.7, 3.7, 3.7, 3.7, 3.7 ],
                     [ 3.7, 3.7, 3.7, 3.7, 3.7, 3.7 ]]
        this.temperatures = [ [20,20], [20,20], [20,20] ]
    }

    close(): void
	{
	}

	async start( intervalSeconds: number): Promise<void>
	{
		this.intervalSeconds = intervalSeconds;

		console.log( "batteryReader.start");
        this.setInterval( intervalSeconds )

		return
	}

	async setBalanceTimer( seconds: number ): Promise<void>
	{
	}

	async balance( cells: boolean[][]): Promise<void>
	{
	}

	async stopBalancing(): Promise<void>
	{
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
        const data: BatteryReader.UpdateData = {
            voltages: clone(this.voltages),
            temperatures: clone(this.temperatures),
            fault: this.hasFault,
            alert: this.hasAlert,
            update_imbalance: this.update_imbalance
        }

        this.emit('update', data );
    
        this.timeout = setTimeout( this.updateReader.bind( this ), this.intervalSeconds! * 1000 )
	}

    updateReader( ): void
    {
        this.update();
    }
}
/*
async function updateReader( reader: BatteryReader.BatteryReader )
{
	return reader.update();
}    
*/
export class SimulatedVESC extends events.EventEmitter implements VESCble.VESCinterface
{
    readonly mcValues = new vescBle.Packet_Values()

    connected = false

    constructor()
    {
        super()
        this.mcValues.type = vescBle.Packet.Types["GET_VALUES"]
        this.mcValues.invalid = true
        this.mcValues.isComplete = true
        this.mcValues.temp_mos = 20;
        this.mcValues.temp_mos_1 = 20;
        this.mcValues.temp_mos_2 = 20;
        this.mcValues.temp_mos_3 = 20;
        this.mcValues.temp_motor = 20;
        this.mcValues.duty = 0;
        this.mcValues.voltage_in = 70;
        this.mcValues.current_in = 0;
        /*
        this.mcValues.current_motor = 0;
        this.mcValues.current_in = 0;
        this.mcValues.current_id = 0;
        this.mcValues.current_iq = 0;
        this.mcValues.duty = 0;
        this.mcValues.rpm = 0;
        this.mcValues.voltage_in = 0;
        this.mcValues.energy_ah = 0;
        this.mcValues.energy_charged_ah = 0;
        this.mcValues.energy_wh: number;
        this.mcValues.energy_charged_wh: number;
        this.mcValues.tachometer: number;
        this.mcValues.tachometer_abs: number;
        this.mcValues.fault: number;
        this.mcValues.pid_pos_now: number;
        this.mcValues.controller_id: number;
        this.mcValues.temp_mos_1: number;
        this.mcValues.temp_mos_2: number;
        this.mcValues.temp_mos_3: number;
        this.mcValues. vq: number;
        this.mcValues.vd: number;
        */
    }
    async ble_connect( ): Promise<void>
    {
        console.log( "Connected to simulated VESC" )
        this.connected = true
        this.mcValues.invalid = false
        this.emit('connected')
        return Promise.resolve()
    }

    async getValues(): Promise<void>
    {
        // console.log( "SimulatedVESC.getValues, invalid=" + this.mcValues.invalid )
        // console.log( )
        this.emit('packet', clone(this.mcValues) )

        return Promise.resolve()
    }

    sendCAN( id: number, data: Uint8Array, withResponse: boolean ): Promise<void>
    {
        return Promise.resolve()

    }
}