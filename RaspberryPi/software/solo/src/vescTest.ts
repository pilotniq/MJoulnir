import * as VESCble from "vesc-ble"
import * as noble from '@abandonware/noble';

const vesc = new VESCble.VESC();

vesc.on( 'packet', receivePacket );
vesc.on( 'connected', connected );

console.log( "noble state is " + noble.state );
// noble.on("stateChange", (state: string) => {
    vesc.ble_connect( ).
        then( () => { console.log( "setInterval" ); setInterval( ()=>vesc.sendCANCharge( 60, 1, false), 1000) });
        

function connected(): void 
{
    console.log( "VESCtalker conencted via BLE" );
    vesc.getValues().then( () => { console.log( "getValues returned" ); });
}

function receivePacket( packet: VESCble.Packet ): void
{
    console.log( "Got VESC BLE packet, type=" + packet.type );
}
