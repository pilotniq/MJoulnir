/*
 * vesc.ts
 *
 * Communicate with the VESC
 */
import * as events from 'events';
import * as BoatModel from "./boatModel"
import * as VESCble from 'vesc-ble'
import { TimeoutFn } from 'ava';

function assert(value: boolean): void 
{
	if( !value )
		throw new Error("assertion failed")
}

export enum MCFaultCode { None = 0, 
	OverVoltage,
	UnderVoltage,
	DRV,
	ABSOverCurrent,
	OverTempFET,
	OverTempMotor,
	GateDriverOverVoltage,
	GateDriverUnderVoltage,
	MCUUnderVoltage,
	BootingFromWatchdogReset,
	EncoderSPI,
	EncoderSincosBelowMinAmplitude,
	EncoderSincosAboveMaxAmplitude,
	CodeFlashCorruption,
	CodeHighOffsetCurrentSensor1,
	CodeHighOffsetCurrentSensor2,
	CodeHighOffsetCurrentSensor3,
	CodeUnbalancedCurrents,
	CodeBRK,
	CodeResolverLOT,
	CodeResolverDOS,
	CodeResolverLOS,
	CodeFlashCorruptionAppCFG,
	CodeFlashCorruptionMCCFG,
	CodeEncoderNoMagnet }

export class VESCtalker extends events.EventEmitter
{
    // vescModel: BoatModel.VESC;
    vesc: VESCble.VESCinterface;
    // This timeout handles both interval and timeouts.
    // if it expires, a new getValues should be sent
    pollMCValuesTimeout?: NodeJS.Timeout
    // 0 below means no polling
    pollMCValuesintervalSeconds = 0
    inMCValueAutoPoll = false
    pollMCValuesInFlight = 0

    constructor( /* model: BoatModel.BoatModel, */ vesc: VESCble.VESCinterface )
    {
        super();

        // this.vescModel = model.vescState;
        this.vesc = vesc /* new VESCble.VESC() */;

        this.vesc.on( 'packet', this.receivePacket.bind(this) );
        this.vesc.on( 'connected', this.connected.bind(this) );
        // this.vesc.ble_connect( );
    }

    public async connect(): Promise<void>
    {
        return this.vesc.ble_connect()
    }

    public setPollMCValueInterval( newInterval: number ): void
	{
		if( !(this.pollMCValuesTimeout === undefined) )
			clearTimeout( this.pollMCValuesTimeout );

		this.pollMCValuesintervalSeconds = newInterval;

        if( newInterval != 0 )
            this.autoPollMCValuesWithTimeout()
    }

    autoPollMCValuesWithTimeout(): void
    {
        assert( this.pollMCValuesintervalSeconds != 0 )

        this.vesc.getValues()
        this.pollMCValuesTimeout = setTimeout( this.autoPollMCValuesWithTimeout.bind(this), 
            (this.pollMCValuesintervalSeconds * 1000) )
    }

    connected(): void 
    {
        console.log( "VESCtalker conencted via BLE" );
        this.vesc.getValues().then( () => { console.log( "getValues returned" ); });
    }

    receivePacket( packet: VESCble.Packet ): void
    {
        // console.log( "Got VESC BLE packet, type=" + packet.type );

        switch( packet.type )
        {
            case VESCble.Packet.Types["GET_VALUES"]:
                this.processGetValues( packet as VESCble.Packet_Values)
                break;

            case VESCble.Packet.Types["CAN_FWD_FRAME"]:
                // console.log( "Got CAN frame!");
                this.emit( 'CAN', packet );
                // TODO: handle according to ID.
                break;
        }
    }

    processGetValues( packet: VESCble.Packet_Values ): void
    {
        /*
        const fields = ["voltage_in", "temp_mos",
            "temp_mos_1", "temp_mos_2", "temp_mos_3", "temp_motor", 
            "current_motor", "current_in", "id", "iq", "rpm", "duty_now", 
            "amp_hours", "amp_hours_charged", "watt_hours", "watt_hours_charged", 
            "tachometer", "tachometer_abs", "position", "fault_code",
            "vesc_id", "vd", "vq" ]
        */
       this.emit( "values", packet )
       /*
        this.vescModel.updateMCValues( packet.voltage_in, 
            packet.temp_mos, packet.temp_mos_1, packet.temp_mos_2, packet.temp_mos_3, 
            packet.temp_motor, packet.current_motor, 
            packet.current_in, packet.current_id, packet.current_iq, 
            packet.rpm, packet.duty, packet.energy_ah,
            packet.energy_charged_ah, packet.energy_wh, packet.energy_charged_wh,
            packet.tachometer, packet.tachometer_abs, packet.pid_pos_now, 
            packet.fault, packet.controller_id, packet.vd, packet.vq )

        /*
        console.log( "Got VESC Values, voltage_in=" + packet.voltage_in + 
            " V, current_in=" + packet.current_in + 
            " A, temp_mos=" + packet.temp_mos.toFixed(1) + " C" );
        */
        // this.vescModel.signalUpdated();
        
    }

    async sendCAN( id: number, data: Uint8Array, withResponse: boolean ): Promise<void>
    {
        return this.vesc.sendCAN( id, data, withResponse );
    }

    public async getValues(): Promise<void>
    {
        // reset pollng timer if an explicit getValues is done
        if( this.pollMCValuesTimeout !== undefined )
        {
            clearTimeout( this.pollMCValuesTimeout )
            this.pollMCValuesTimeout = setTimeout( this.autoPollMCValuesWithTimeout.bind(this), 
                (this.pollMCValuesintervalSeconds * 1000) )
        }

        return this.vesc.getValues()
    }
}
