import * as events from 'events';
import { LoopDetected } from 'http-errors';

import Koa, { Middleware } from 'koa'
import serve = require('koa-static')
import Router from 'koa-router'

import rfdc from "rfdc";

import * as VESCble from 'vesc-ble'
import * as VESCreader from "./vesc"

// import vescBle from 'vesc-ble';

import * as BatteryReader from './batteryReader'
import {Charger, ChargerError} from './chargerInterface'
import { LowLevelHardware } from './lowLevelHardware'
import { timeStamp } from 'node:console';

const clone = rfdc();

export class SimulatedBoat implements LowLevelHardware
{
    readonly PORT = 8080
    readonly app: Koa
    readonly router: Router
    // readonly helloWorldController: Middleware

    public readonly batteryReader: SimulatedBatteryReader
    public readonly vesc: SimulatedVESC
    public readonly charger: SimulatedCharger

    precharge = false
    contactor = false

    readonly vescTalker: VESCreader.VESCtalker

    connectResolve?: () => void

    constructor()
    {
        this.batteryReader = new SimulatedBatteryReader()
        this.vesc = new SimulatedVESC()
        this.vescTalker = new VESCreader.VESCtalker(this.vesc) // bleVESC: VESCble.VESCinterface
        this.charger = new SimulatedCharger(this.batteryReader)

        this.app = new Koa();
        this.router = new Router();
        /*
        this.helloWorldController = async (ctx) => {
            console.log( "Received a request");
            ctx.body =  {
                message: 'Hello World!'
            }
        }
*/
        // this.router.get( '/', this.helloWorldController )
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

        this.router.post( '/api/v1/charger/detected', async (ctx) => {
            console.log( "Received an API call to set charger detected" + ctx.request.path);
            console.log( "Query" + JSON.stringify(ctx.request.query));
            console.log( "href: " + JSON.stringify(ctx.request.href));
            console.log( "type: " + ctx.request.type );
            // console.log( "body: " + ctx.req.body );
            
            const query = ctx.request.query
            const detected = query['detected']

            if(typeof detected ==="string")
            {
                this.charger.setDetected( Boolean(JSON.parse(detected)) )
            }
            else
                console.log( "typeof detected is " + (typeof detected))

            ctx.body =  {
                message: 'OK!'
            }
        }
        )

        this.router.post( '/api/v1/charger/powered', async (ctx) => {
            console.log( "Received an API call to set charger detected" + ctx.request.path);
            console.log( "Query" + JSON.stringify(ctx.request.query));
            console.log( "href: " + JSON.stringify(ctx.request.href));
            console.log( "type: " + ctx.request.type );
            // console.log( "body: " + ctx.req.body );
            
            const query = ctx.request.query
            const powered = query['powered']

            if(typeof powered ==="string")
            {
                this.charger.setPowered( Boolean(JSON.parse(powered)) )
            }
            else
                console.log( "typeof powered is " + (typeof powered))

            ctx.body =  {
                message: 'OK!'
            }
        }
        )
        this.app.use( this.router.routes())
            .use( this.router.allowedMethods())
        this.app.use( serve("/home/pi/src/electric-boat/RaspberryPi/software/solo/web-static"))

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

export class SimulatedCharger extends events.EventEmitter implements Charger
{
    detected = false
    powered = false
    do_charge = false
    simulationTimer?: NodeJS.Timer

    max_voltage = 0
    max_current = 0

    acc_charge_J = 0;

    output_voltage = 0;
    output_current = 0;

    errorBits = 0;

	last_update_time?: Date;

    private battery: SimulatedBatteryReader

    constructor( battery: SimulatedBatteryReader )
    {
        super()
        this.battery = battery
    }

    setDetected(detected: boolean): void 
    {
        const changed = detected != this.detected

        this.detected = detected

        console.log( "Simulateted charger detected: " + detected )
        if( changed )
            this.emit('changed')
    }

    setPowered(powered: boolean): void 
    {
        const changed = powered != this.powered

        this.powered = powered

        console.log( "Simulateted charger powered: " + powered )
        if( changed )
            this.emit('changed')
    }

    setChargingParameters(max_voltage: number, max_current: number, doCharge: boolean): void {
        this.max_voltage = max_voltage
        this.max_current = max_current
        this.do_charge = doCharge

        this.updateSimulation()
    }

    updateSimulation(): void
    {
        if( this.simulationTimer == undefined && 
            this.detected && 
            this.powered && 
            this.do_charge )
        {
            console.log( "Starting charger simulation timer")
            this.simulationTimer = setTimeout(  this.simulate.bind(this), 2000 )
            this.output_voltage = this.battery.getVoltage()
        }
        else
        {
            console.log( "***Charger: Not simulating: detected=" + this.detected + 
                ", timer=" + this.simulationTimer +
                ", powered=" + this.powered + 
                ", do_charge=" + this.do_charge )
        }
    }

    simulate(): void
    {
        this.simulationTimer = undefined
        console.log( "Charger: simulate()")
        if( !this.detected || !this.powered || !this.do_charge || this.errorBits != 0 )
        {
            console.log( "Stopping charging simulation")
            return
        }

        if( this.battery.getVoltage() < this.max_voltage && 
            this.output_current < this.max_current)
        {
            this.output_current += 1
            if( this.output_current > this.max_current )
                this.output_current = this.max_current
        }

        const power = this.output_current * this.output_voltage
        const energy = power * 2 // in Joules, two seconds between updates

        this.battery.addEnergy( this.output_current, energy )
        this.acc_charge_J += energy

        this.emit('changed');

        this.updateSimulation()
    }
}

class SimulatedBatteryReader extends events.EventEmitter implements BatteryReader.BatteryReader
{
    intervalSeconds?: number; // just some value before started to make TS happy 
    update_imbalance = false
    timeout?: NodeJS.Timer // ?? Why doesn't NodeJS.Timer work? */

    resistancePerCellGroup = 0.003
    // 3 to 4.2 volts 
    joulesPerVoltCellGroup = 5300 * 3600 / (1.2 * 6)
    current = 0

    // these are the voltages not including inner resistance
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

    public getVoltage(): number
    {
        return this.voltages.reduce( (sum, moduleVoltages) => moduleVoltages.reduce( (sum2, voltage) => sum + voltage, sum), 0) +
            this.current * this.resistancePerCellGroup * 18
    }

    public calculateVoltages(): number[][]
    {
        const result = clone(this.voltages)

        for( let moduleIndex = 0; moduleIndex < result.length; moduleIndex++ )
            for( let cellIndex = 0; cellIndex < result[moduleIndex].length; cellIndex++ )
                result[moduleIndex][cellIndex] += this.current * this.resistancePerCellGroup

        return result
    }

    public addEnergy( current: number, joules: number )
    {
        const dVoltage = joules / this.joulesPerVoltCellGroup

        for( let moduleIndex = 0; moduleIndex < this.voltages.length; moduleIndex++)
            for( let cellGroupIndex = 0; cellGroupIndex < this.voltages[moduleIndex].length; cellGroupIndex++)
                this.voltages[moduleIndex][cellGroupIndex] += dVoltage

        this.current = current
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
            voltages: this.calculateVoltages(),
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