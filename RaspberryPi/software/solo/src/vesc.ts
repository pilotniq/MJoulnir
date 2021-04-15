/*
 * vesc.ts
 *
 * Communicate with the VESC
 */
import * as events from 'events';
import * as BoatModel from "./boatModel"
import * as VESCble from 'vesc-ble'
// import * as noble from "@abandonware/noble"

export class VESCtalker extends events.EventEmitter
{
    model: BoatModel.BoatModel;
    vesc: VESCble.VESC;

    constructor( model: BoatModel.BoatModel)
    {
        super();

        this.model = model;
        this.vesc = new VESCble.VESC();

        this.vesc.on( 'packet', this.receivePacket.bind(this) );
        this.vesc.on( 'connected', this.connected.bind(this) );
        this.vesc.ble_connect( );
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
                console.log( "Got Values, not handled yet" );
                // TODO: copy to model
                break;

            case VESCble.Packet.Types["CAN_FWD_FRAME"]:
                // console.log( "Got CAN frame!");
		        this.emit( 'CAN', packet );
                // TODO: handle according to ID.
                break;
        }
    }

    async sendCAN( id: number, data: Uint8Array, withResponse: boolean ): Promise<void>
    {
        return this.vesc.sendCAN( id, data, withResponse );
    }
}

