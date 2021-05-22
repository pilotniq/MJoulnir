import * as events from 'events';

import Koa, { Middleware } from 'koa'
import Router from 'koa-router'

import rfdc from "rfdc";

import * as VESCble from 'vesc-ble'
// import vescBle from 'vesc-ble';

import * as BatteryReader from './batteryReader'

import { LowLevelHardware } from './lowLevelHardware'

const clone = rfdc();

export class SimulatedBoat implements LowLevelHardware
{
    readonly PORT = 8080
    readonly app: Koa
    readonly router: Router
    readonly helloWorldController: Middleware

    public readonly batteryReader: SimulatedBatteryReader
    public readonly vesc: SimulatedVESC

    precharge = false
    contactor = false

    connectResolve?: () => void

    constructor()
    {
        this.batteryReader = new SimulatedBatteryReader()
        this.vesc = new SimulatedVESC()

        this.app = new Koa();
        this.router = new Router();
        this.helloWorldController = async (ctx) => {
            console.log( "Received a request");
            ctx.body =  {
                message: 'Hello World!'
            }
        }

        this.router.get( '/', this.helloWorldController )
        this.router.post( '/api/v1/vesc/throttle', async (ctx) => {
            console.log( "Received an API call to set throttle" + ctx.request.path);
            console.log( "Query" + JSON.stringify(ctx.request.query));
            const query = ctx.request.query
            const throttle = query['throttle']

            if(typeof throttle ==="string")
            {
                this.vesc.setThrottle( parseFloat(throttle) )
            }
            ctx.body =  {
                message: 'OK!'
            }
        }
        )

        this.app.use( this.router.routes())
            .use( this.router.allowedMethods())
        this.app.listen( this.PORT, () => { console.log( "Server on port " + this.PORT)})
    }

    setPrecharge( value: boolean ): void
    {
        this.precharge = value
    }

	setContactor( value: boolean ): void
    {
        this.contactor = value

        // this turns on the vesc
        this.vesc.turnOn()
    }

}

class SimulatedBatteryReader extends events.EventEmitter implements BatteryReader.BatteryReader
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
    readonly mcValues = new VESCble.Packet_Values()

    connected = false
    isOn = false
    last_simulation_update?: number

    connectResolve?: () => void

    constructor()
    {
        super()
        this.mcValues.type = VESCble.Packet.Types["GET_VALUES"]
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
        this.mcValues.energy_ah = 0;
        this.mcValues.energy_charged_ah = 0;
        this.mcValues.energy_wh = 0;
        this.mcValues.energy_charged_wh = 0;
        /*
        this.mcValues.current_motor = 0;
        this.mcValues.current_in = 0;
        this.mcValues.current_id = 0;
        this.mcValues.current_iq = 0;
        this.mcValues.duty = 0;
        this.mcValues.rpm = 0;
        this.mcValues.voltage_in = 0;
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
       setInterval( this.simulate.bind(this), 1000)
    }

    turnOn()
    {
        this.isOn = true
    }

    async ble_connect( ): Promise<void>
    {
        if( this.isOn )
            this.doConnect()
        else
        {
            return new Promise<void>( (resolve, reject) => {
                this.connectResolve = resolve
                this.waitUntilOn()
            })
        }
    }

    waitUntilOn(): void 
    {
        setTimeout( () => { 
            if( this.isOn )
                this.connectResolve!()
            else
                setTimeout( this.waitUntilOn.bind(this), 1000 )
        }) 
    }

    doConnect(): void
    {
        console.log( "Connected to simulated VESC" )
        this.connected = true
        this.mcValues.invalid = false
        this.emit('connected')

    }
    async getValues(): Promise<void>
    {
        console.log( "SimulatedVESC.getValues, invalid=" + this.mcValues.invalid )
        // console.log( )
        this.emit('packet', clone(this.mcValues) )
        this.emit('values', clone(this.mcValues) )

        return Promise.resolve()
    }

    sendCAN( id: number, data: Uint8Array, withResponse: boolean ): Promise<void>
    {
        return Promise.resolve()
    }

    setThrottle( value: number ): void
    {

        const power = -10000 * value
    
        this.mcValues.duty = value
        this.mcValues.current_in = power / this.mcValues.voltage_in

        this.getValues()
    }

    simulate(): void
    {        
        if( this.last_simulation_update === undefined )
        {
            this.last_simulation_update = Date.now()
            console.log( "simulate, set last_simulation_update to " + this.last_simulation_update)
            return
        }

        // console.log( "simulate called, energy_wh in=" + this.mcValues.energy_wh)

        const power = -10000 * this.mcValues.duty
        const now = Date.now()
        const dt = (now - this.last_simulation_update!) / 1000.0

        this.last_simulation_update = now

        // console.log( "simulate called, energy_wh in=" + this.mcValues.energy_wh + ", dt=" + dt)

        this.mcValues.current_in = power / this.mcValues.voltage_in
        this.mcValues.energy_ah += this.mcValues.current_in * dt / 3600
        this.mcValues.energy_wh += this.mcValues.current_in * this.mcValues.voltage_in * dt / 3600
        this.mcValues.invalid = false
        this.mcValues.isComplete = true
        // console.log( "simulate called, energy_wh=" + this.mcValues.energy_wh)
    }
}

/*
export class SimulatedHardware implements LowLevelHardware
{
    precharge = false
    contactor = false

    setPrecharge( value: boolean ): void
    {
        this.precharge = value
    }

	setContactor( value: boolean ): void
    {
        this.contactor = value
    }
}
*/