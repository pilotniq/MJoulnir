const { stat } = require("fs");
const EventEmitter = require('events');

const noble = require('@abandonware/noble');

const UARTServiceUUID = '6e400001b5a3f393e0a9e50e24dcca9e'
const UARTTxUUID =      '6e400002b5a3f393e0a9e50e24dcca9e'
const UARTRxUUID =      '6e400003b5a3f393e0a9e50e24dcca9e'

class Packet
{
	static crc16_tab = [ 0x0000, 0x1021, 0x2042, 0x3063, 0x4084,
		0x50a5, 0x60c6, 0x70e7, 0x8108, 0x9129, 0xa14a, 0xb16b, 0xc18c, 0xd1ad,
		0xe1ce, 0xf1ef, 0x1231, 0x0210, 0x3273, 0x2252, 0x52b5, 0x4294, 0x72f7,
		0x62d6, 0x9339, 0x8318, 0xb37b, 0xa35a, 0xd3bd, 0xc39c, 0xf3ff, 0xe3de,
		0x2462, 0x3443, 0x0420, 0x1401, 0x64e6, 0x74c7, 0x44a4, 0x5485, 0xa56a,
		0xb54b, 0x8528, 0x9509, 0xe5ee, 0xf5cf, 0xc5ac, 0xd58d, 0x3653, 0x2672,
		0x1611, 0x0630, 0x76d7, 0x66f6, 0x5695, 0x46b4, 0xb75b, 0xa77a, 0x9719,
		0x8738, 0xf7df, 0xe7fe, 0xd79d, 0xc7bc, 0x48c4, 0x58e5, 0x6886, 0x78a7,
		0x0840, 0x1861, 0x2802, 0x3823, 0xc9cc, 0xd9ed, 0xe98e, 0xf9af, 0x8948,
		0x9969, 0xa90a, 0xb92b, 0x5af5, 0x4ad4, 0x7ab7, 0x6a96, 0x1a71, 0x0a50,
		0x3a33, 0x2a12, 0xdbfd, 0xcbdc, 0xfbbf, 0xeb9e, 0x9b79, 0x8b58, 0xbb3b,
		0xab1a, 0x6ca6, 0x7c87, 0x4ce4, 0x5cc5, 0x2c22, 0x3c03, 0x0c60, 0x1c41,
		0xedae, 0xfd8f, 0xcdec, 0xddcd, 0xad2a, 0xbd0b, 0x8d68, 0x9d49, 0x7e97,
		0x6eb6, 0x5ed5, 0x4ef4, 0x3e13, 0x2e32, 0x1e51, 0x0e70, 0xff9f, 0xefbe,
		0xdfdd, 0xcffc, 0xbf1b, 0xaf3a, 0x9f59, 0x8f78, 0x9188, 0x81a9, 0xb1ca,
		0xa1eb, 0xd10c, 0xc12d, 0xf14e, 0xe16f, 0x1080, 0x00a1, 0x30c2, 0x20e3,
		0x5004, 0x4025, 0x7046, 0x6067, 0x83b9, 0x9398, 0xa3fb, 0xb3da, 0xc33d,
		0xd31c, 0xe37f, 0xf35e, 0x02b1, 0x1290, 0x22f3, 0x32d2, 0x4235, 0x5214,
		0x6277, 0x7256, 0xb5ea, 0xa5cb, 0x95a8, 0x8589, 0xf56e, 0xe54f, 0xd52c,
		0xc50d, 0x34e2, 0x24c3, 0x14a0, 0x0481, 0x7466, 0x6447, 0x5424, 0x4405,
		0xa7db, 0xb7fa, 0x8799, 0x97b8, 0xe75f, 0xf77e, 0xc71d, 0xd73c, 0x26d3,
		0x36f2, 0x0691, 0x16b0, 0x6657, 0x7676, 0x4615, 0x5634, 0xd94c, 0xc96d,
		0xf90e, 0xe92f, 0x99c8, 0x89e9, 0xb98a, 0xa9ab, 0x5844, 0x4865, 0x7806,
		0x6827, 0x18c0, 0x08e1, 0x3882, 0x28a3, 0xcb7d, 0xdb5c, 0xeb3f, 0xfb1e,
		0x8bf9, 0x9bd8, 0xabbb, 0xbb9a, 0x4a75, 0x5a54, 0x6a37, 0x7a16, 0x0af1,
		0x1ad0, 0x2ab3, 0x3a92, 0xfd2e, 0xed0f, 0xdd6c, 0xcd4d, 0xbdaa, 0xad8b,
		0x9de8, 0x8dc9, 0x7c26, 0x6c07, 0x5c64, 0x4c45, 0x3ca2, 0x2c83, 0x1ce0,
		0x0cc1, 0xef1f, 0xff3e, 0xcf5d, 0xdf7c, 0xaf9b, 0xbfba, 0x8fd9, 0x9ff8,
		0x6e17, 0x7e36, 0x4e55, 0x5e74, 0x2e93, 0x3eb2, 0x0ed1, 0x1ef0 ];
	
	static States = { "SizeByte": { "func": Packet.parseSize },
				"LengthByte": { "func": Packet.parseByteField, 
						"context": {"field": "length", "nextState": "Type"} },
				"Length16": { "func": Packet.parseMulti, 
						"context": {"field": "length", "byte_count": 2, "nextState": "Type"}},
				"Type": { "func": Packet.parseType },
				"GetValues_temp_mos": { func: Packet.parseMulti,
						"context": {
							"field": "temp_mos", 
							"byte_count": 2, 
							"scale": 10, 
							"nextState": "GetValues_temp_motor"}},
				"GetValues_temp_motor": { func: Packet.parseMulti,
						"context": {
							"field": "temp_motor", 
							"byte_count": 2, 
							"scale": 10,
							"nextState": "GetValues_current_motor"}},
				"GetValues_current_motor": { func: Packet.parseMulti,
						"context": {
							"field": "current_motor", 
							"byte_count": 4,
							"scale": 100,
							"nextState": "GetValues_current_in"}},
				"GetValues_current_in": { func: Packet.parseMulti,
						"context": {
							"field": "current_in", 
							"byte_count": 4,
							"scale": 100,
							"nextState": "GetValues_current_id"}},
				"GetValues_current_id": { func: Packet.parseMulti,
						"context": {
							"field": "current_id",
							"byte_count": 4,
							"scale": 100,
							"nextState": "GetValues_current_iq"}},
				"GetValues_current_iq": { func: Packet.parseMulti,
						"context": {
							"field": "current_iq",
							"byte_count": 4,
							"scale": 100,
							"nextState": "GetValues_current_duty"}},
				"GetValues_current_duty": { func: Packet.parseMulti,
						"context": {
							"field": "duty",
							"byte_count": 2,
							"scale": 1000,
							"nextState": "GetValues_current_rpm"}},
				"GetValues_current_rpm": { func: Packet.parseMulti,
						"context": {
							"field": "rpm",
							"byte_count": 4,
							"nextState": "GetValues_voltage_in"}},
				"GetValues_voltage_in": { func: Packet.parseMulti,
						"context": {
							"field": "voltage_in",
							"byte_count": 2,
							"scale": 10,
							"nextState": "GetValues_energy_ah"}},
				"GetValues_energy_ah": { func: Packet.parseMulti,
						"context": {
							"field": "energy_ah",
							"byte_count": 4,
							"scale": 10000,
							"nextState": "GetValues_energy_charged"}},
				"GetValues_energy_charged": { func: Packet.parseMulti,
						"context": {
							"field": "energy_charged_ah",
							"byte_count": 4,
							"scale": 10000,
							"nextState": "GetValues_energy_wh"}},
				"GetValues_energy_wh": { func: Packet.parseMulti,
						"context": {
							"field": "energy_wh",
							"byte_count": 4,
							"scale": 10000,
							"nextState": "GetValues_energy_wh_charged"}},
				"GetValues_energy_wh_charged": { func: Packet.parseMulti,
						"context": {
							"field": "energy_charged_wh",
							"byte_count": 4,
							"scale": 10000,
							"nextState": "GetValues_tachometer"}},
				"GetValues_tachometer": { func: Packet.parseMulti,
						"context": {
							"field": "tachometer",
							"byte_count": 4,
							"nextState": "GetValues_tachometer_abs"}},
				"GetValues_tachometer_abs": { func: Packet.parseMulti,
						"context": {
							"field": "tachometer_abs",
							"byte_count": 4,
							"nextState": "GetValues_fault"}},
				"GetValues_fault": { func: Packet.parseByteField,
						"context": {
							"field": "fault",
							"nextState": "GetValues_pid_pos_now"}},
				"GetValues_pid_pos_now": { func: Packet.parseMulti,
						"context": {
							"field": "pid_pos_now",
							"byte_count": 4,
							"scale": 1000000,
							"nextState": "GetValues_controller_id"}},
				"GetValues_controller_id": { func: Packet.parseByteField,
						"context": {
							"field": "controller_id",
							"nextState": "GetValues_temp_mos1"}},
				"GetValues_temp_mos1": { func: Packet.parseMulti,
						"context": {
							"field": "temp_mos_1",
							"byte_count": 2,
							"scale": 10,
							"nextState": "GetValues_temp_mos2"}},
				"GetValues_temp_mos2": { func: Packet.parseMulti,
						"context": {
							"field": "temp_mos_2",
							"byte_count": 2,
							"scale": 10,
							"nextState": "GetValues_temp_mos3"}},
				"GetValues_temp_mos3": { func: Packet.parseMulti,
						"context": {
							"field": "temp_mos_3",
							"byte_count": 2,
							"scale": 10,
							"nextState": "GetValues_vd"}},
				"GetValues_vd": { func: Packet.parseMulti,
						"context": {
							"field": "vd",
							"byte_count": 4,
							"scale": 1000,
							"nextState": "GetValues_vq"}},
				"GetValues_vq": { func: Packet.parseMulti,
						"context": {
							"field": "vq",
							"byte_count": 4,
							"scale": 1000,
							"nextState": "WaitForCRC"}},
				"CAN_ID": { func: Packet.parseMulti,
						"context": {
							"field": "id",
							"byte_count": 4,
							"nextState": "CANisExtended"
						}},
				"CANisExtended": { func: Packet.parseMulti,
					"context": {
						"field": "isExtended",
						"byte_count": 1,
						"nextState": "CANdata"
					}},
				"CANdata": { func: Packet.parseRestToBuffer,
					"context": {
						"field": "data",
					}},
				"SkipUnknownType": { func: Packet.parseRestToBuffer,
					"context": {
						"field": "data",
					}},
				"WaitForCRC": { func: Packet.parseWaitForCRC },
				"WaitForCRCLow": { func: Packet.parseWaitForCRCLow },
				"WaitForStop": { func: Packet.parseWaitForStop },
			}

	// Types correspond to COMM_PACKET_ID in vesc's datatypes.h
	static Types = { "GET_VALUES": 4, 
                         "SET_HANDBRAKE": 10, 
                         "SET_APPCONF": 0x10, 
                         "GET_DECODED_ADC": 0x20,
			 "SET_MCCONF_TEMP": 0x30,
			 "COMM_TERMINAL_CMD_SYNC": 0x40,
			 "BM_MEM_READ": 0x50, // 80
			 "CAN_FWD_FRAME": 0x55 // = 85
			};
	
	constructor() { 
		this.state = Packet.States.SizeByte; 
		this.checksum = 0;
	}

	updateChecksum( byte )
	{
		let oldChecksum = this.checksum;
		this.checksum = (Packet.crc16_tab[(((this.checksum >> 8) ^ byte) & 0xFF)] ^ (this.checksum << 8)) & 0xffff;
		// console.log( "CRC: old=" + oldChecksum.toString(16) + ", byte=" + byte.toString(16) + ", new=" + this.checksum.toString(16) )
	}

	// payload is a buffer
	static calculateChecksum( payload )
	{
		return payload.reduce( (previousCRC, byte) => (Packet.crc16_tab[(((previousCRC >> 8) ^ byte) & 0xFF)] ^ (previousCRC << 8)) & 0xffff, 0)
	}

	parse( byte ) { 
		if( this.state == Packet.States["WaitForCRC"])
			this.inPayload = false;

		if( this.inPayload )
		{
			this.payload_byte_count++;
			this.updateChecksum(byte);
		}

		if( this.state.context )
			this.state.func( this, byte, this.state.context ); 
		else
			this.state.func( this, byte );
	}

	static parseSize( packet, byte)
	{
		// console.log( "parseSize" );
		switch( byte )
		{
			case 2:
				packet.state = Packet.States.LengthByte;
				// console.log( "parseSize: state = " + packet.state );
				// console.log( "Packet.States.LengthByte=" + Packet.States.LengthByte);
				// console.log( "Packet.States['LengthByte']=" + Packet.States['LengthByte']);
				break;

			case 3:
				packet.state = Packet.States.LengthHigh;
				break;

			default:
				packet.invalid = true;
				console.log( "Invalid size byte " + byte );
				break; // stay in initial state, flag invalid
		}
	}

	static parseByteField( packet, byte, context )
	{
		packet[ context.field ] = byte;
		// console.log( "parseByteField: " + context.field + " = " + byte );
		// console.log( "parseByteField: next state is '" + context.nextState + "'" )
		// console.log( "context: " + JSON.stringify(context))
		packet.state = Packet.States[ context.nextState ];
		// console.log( "state=" + packet.state );
		packet.inPayload = true; 
	}

	static parseMulti( packet, byte, context )
	{
		var index, value;

		if( !packet._multi_index )
		{
			value = byte;
			index = 0;
		}
		else
		{
			index = packet._multi_index;
			value = packet._multi_value * 256 + byte;
		}

		index++;
		if( index == context.byte_count )
		{
			if( context.scale )
				packet[context.field] = value / context.scale
			else
				packet[context.field] = value
			
			// console.log( "Parsed field '" + context.field + "' = " + packet[context.field]);
			packet._multi_index = 0;
			packet.inPayload = true; // required to switch to payload after long size

			if( context.nextState in Packet.States )
				packet.state = Packet.States[context.nextState];
			else
			{
				console.log( "Invalid next state '" + context.nextState );
				console.log( "Context: " + JSON.stringify( context ));
			}
			// console.log( "multi: Next state: " + context.nextState );
			// console.log( "state=" + packet.state );
		}
		else
		{
			packet._multi_index = index;
			packet._multi_value = value;
		}
	}

	static parseShortLength( header, byte )
	{
		header.length = byte;
		header.state = PacketHeader.States.Type;
		header.inPayload = true;
	}

	static parseType( packet, byte )
	{
		// console.log( "ParseType");
		packet.type = byte;
		packet.inPayload = true;
		packet.payload_byte_count = 0;

		switch( byte )
		{
			case Packet.Types.GET_VALUES:
				packet.state = Packet.States["GetValues_temp_mos"];
				// console.log( "parseType GET_VALUES: state=" + packet.state);
				break;

			case Packet.Types.CAN_FWD_FRAME:
				packet.state = Packet.States["CAN_ID"];
				break;

			default:
				console.log( "Unknown packet type " + byte );
				packet.invalid = true;
				packet.state = Packet.States["SkipUnknownType"];
				break;
		}
	}

	// example packet:
	// 02 0e 5518ff50e5010002000018000000 228f03
	static parseRestToBuffer( packet, byte, context )
	{
		let fieldName = context["field"]
		var buffer;

		if( !(fieldName in packet) )
		{
			let byteCount = packet.length - packet.payload_byte_count; // length included in packet
			// console.log( "parseRest: byteCount=" + byteCount + ", payload_byte_count=" + packet.payload_byte_count );
			buffer = Buffer.alloc( byteCount );
			packet[fieldName] = buffer;
			packet.restCounter = 0;
		}
		else
			buffer = packet[fieldName]

		buffer[ packet.restCounter ] = byte;

		// console.log( "buffer[ " + packet.restCounter + " ] = " + byte.toString(16));
		packet.restCounter++;
		// console.log( "parseRest: restCounter=" + packet.restCounter + ", packetlength=" + packet.length);

		if( (packet.payload_byte_count + 1) == packet.length )
			packet.state = Packet.States["WaitForCRC"];
	}

	static parseWaitForCRC( packet, byte )
	{
		packet.crc = byte << 8;

		packet.state = Packet.States["WaitForCRCLow"];
	}

	static parseWaitForCRCLow( packet, byte )
	{
		packet.crc = packet.crc | byte;

		if( packet.crc != packet.checksum )
			console.log( "Bad checksum=" + packet.checksum.toString(16) + ", crc=" + packet.crc.toString(16) );

		// todo: validate checksum
		packet.state = Packet.States["WaitForStop"];
	}

	static parseWaitForStop( packet, byte )
	{
		if( byte == 3 )
		{
			// console.log( "Complete packet " + JSON.stringify( packet ) );
			packet.isComplete = true;
		}
		else
		{
			console.log( "Invalid stop byte, got " + byte );
			packet.invalid = true; // go to initial state?
		}
	}

}

/*
class Packet
{
	constructor() {
		this.state = Packet.States.SizeByte;
	}

	process( byte )
	{
		switch( this.state )
		{
			case PacketHeader.States.SizeByte:
				
		}
	}
}
*/
class VESC extends EventEmitter
{
	constructor(  )
	{
		super();
		this.currentPacket = new Packet();
	}

	async ble_connect( )
	{
		var vesc = this;
		// this.noble = noble;

		return new Promise( (resolve, reject) => {
			// TODO: Add Timeout 
			noble.on('discover', peripheral => {
				console.log( (new Date()).toISOString() + ": discovered VESC" );
				vesc.ble_peripheral = peripheral;
				noble.stopScanningAsync()
					.then( () => { 
						// xxx commented out 2021-04-14 to see if central keeps advertising
						noble.reset();
						return peripheral.connectAsync()
						} )
					.then( () => peripheral.discoverSomeServicesAndCharacteristicsAsync( [UARTServiceUUID], 
						[UARTRxUUID, UARTTxUUID] ) )
					.then( (sc) => {
						var chars = sc.characteristics;
						if( chars[0].uuid == UARTRxUUID ) {
							vesc.ble_rxCharacteristic = chars[0];
							vesc.ble_txCharacteristic = chars[1];
						}
						else
						{
							vesc.ble_rxCharacteristic = chars[1];
							vesc.ble_txCharacteristic = chars[0];
						}
						vesc.ble_rxCharacteristic.on( 'data', vesc.readPacketData.bind(vesc) );
						vesc.ble_rxCharacteristic.subscribe();
						// vesc.ble_rxCharacteristic.notify(true, (error) => console.log( "notify error: " + error ));

						vesc.connected = true;
						console.log( (new Date()).toISOString() + ": connected" );
						
						this.emit( 'connected' );
						resolve();
						} )
					.catch( (error) => reject( error ) )
			} )
			console.log( "Waiting for noble powerOn (state=" + noble.state + ")" );
			if( noble.state == "poweredOn" )
				this.startScanning();
			else
				noble.on( "stateChange", (state) => { if( state == "poweredOn") vesc.startScanning() } );

		} );
	}

	startScanning()
	{
		console.log( (new Date()).toISOString() + ": starting scanning for VESC" );
		noble.startScanningAsync( [UARTServiceUUID] )
			.then( () => { 
		console.log( (new Date()).toISOString() + ": started scanning for VESC" );
			});
	}

	readPacketData( data, isNotification )
	{
		// console.log( "Got data: " + data.toString( 'hex' ) );
		for( const byte of data )
		{
			this.currentPacket.parse(byte);
			{
				if( this.currentPacket.invalid )
				{
					console.log( "Invalid packet" );
					this.currentPacket = new Packet();
				}
			}
			if( this.currentPacket.isComplete )
			{
				this.emit( 'packet', this.currentPacket );
/*
				if( this.currentPacket.type == Packet.Types["CAN_FWD_FRAME"])
					VESC.printCANpacket( this.currentPacket );
				else
					console.log( "Got packet: " + JSON.stringify( this.currentPacket ) );
				*/
				// TODO: call some callback
				this.currentPacket = new Packet();
			}
		}
	}

	static printCANpacket( packet )
	{
		if( packet.id == 0x18ff50e5 )
		{
			// CCS status:
			console.log( "Charger status: ");
			console.log( "  Output voltage: " + (packet.data[0] * 256 + packet.data[1]) / 10  + " V");
			console.log( "  Output current: " + (packet.data[2] * 256 + packet.data[3]) / 10  + " A");
			let status = packet.data[4];
			console.log( "  status:" + status.toString(16) + ", status & 2=" + (status & 2));
			console.log( "  Hardware: " + ((status & 1) ? "Failure" : "Good"));
			console.log( "  Temperature: " + ((status & 2) ? "Over Temperature Protection": "Normal" ));
			console.log( "  Input Voltage: " + ((status & 4) ? "Wrong": "Normal" ));
			console.log( "  Starting State: " + ((status & 8) ? "Charger off": "Battery detected" ));
			console.log( "  Communication State: " + ((status & 16) ? "Receive timeout": "Normal" ));
		}
		else
			console.log( "Unknown CAN ID " + packet.id.toString(16))
	}

	// data starts with
	async sendPacket( type, data, withResponse )
	{

		// 02 0d 55 1806e5f4 00 00 00 00 01 00 00 00 42c7 03 is too short?
		// GOtData gets:
		// 02 0e 55 18ff50e5 01 00 02 00 00 18 00 00 00 228f 03
		// st sz ty id       extended! volt  curre 
		// console.log( "sendPacket: data=" + data);
		let header = Buffer.from( [0x02, data.length + 1] );
		let payload = Buffer.concat( [new Uint8Array([type]), data] );
		let crc = Packet.calculateChecksum( payload );
		let tailBuffer = Buffer.from( [crc >> 8, crc & 0xff, 3] );
		let buffer = Buffer.concat( [header, payload, tailBuffer] );

		// console.log( "writeAsync " + buffer.toString("hex") );
		return this.ble_txCharacteristic.writeAsync( buffer, !withResponse );
	}

	async getValues()
	{
		if( !this.connected )
			throw 'Not connected';

		return this.ble_txCharacteristic.writeAsync( new Buffer.from([0x02, 0x01, 0x04, 0x40, 0x84, 0x03] ));
	}

	// for now, assume extended
    async sendCAN( id, data /* : Uint8Array */, withResponse )
	{
		// last 0x01 indicates extended
		let idBuffer = Buffer.from( [ (id >> 24) & 0xff, (id >> 16) & 0xff, (id >> 8) & 0xff, id & 0xff, 0x01 ] );
		let dataBuffer = Buffer.from( data );

		let canPacketBuffer = Buffer.concat( [idBuffer, dataBuffer] );

		await this.sendPacket( Packet.Types.CAN_FWD_FRAME, canPacketBuffer, withResponse );
	}
	
	async sendCANCharge( maxVoltage, maxCurrent, chargeOn )
	{
		let v10 = maxVoltage * 10;
		let c10 = maxCurrent * 10;

		let canPacket = Buffer.from([ 0x18, 0x06, 0xe5, 0xf4, 
			(v10 >> 8) & 0xff, v10 & 0xff, (c10 >> 8) & 0xff, c10 & 0xff,
			chargeOn ? 1 : 0, 0, 0 /* , 0 */]);
	
		return this.sendPacket( Packet.Types.CAN_FWD_FRAME, canPacket );
	}
}
/*
noble.on('stateChange', async (state) => {
  if (state === 'poweredOn') {
	console.log( "poweredOn" );
    await noble.startScanningAsync([UARTServiceUUID]);
    // await noble.startScanningAsync(['180f'], false);
  }
});
*/
/*
noble.on('discover', async (peripheral) => {
  console.log( "discovered");
  	await noble.stopScanningAsync();
  	console.log( "connecting " + peripheral.address + "(rssi " + peripheral.rssi + ")");
	noble.reset()
	  await peripheral.connectAsync();
	  console.log( peripheral.rssi + ": " + peripheral.address + ": " + peripheral.advertisement.local_name );
	  // const {characteristics} = await peripheral.discoverSomeServicesAndCharacteristicsAsync(['1a00'], ['2a19']);
	  // const {characteristics2} = await peripheral.discoverSomeServicesAndCharacteristicsAsync(['1a00']);
	  const {services, ch1} = await peripheral.discoverAllServicesAndCharacteristicsAsync();
	console.log("Services: " + services );
	console.log("Characteristics: " + ch1 );
	
	  // const batteryLevel = (await characteristics[0].readAsync())[0];
	  console.log(`${peripheral.address} (${peripheral.advertisement.localName})`);
	const uartService = await peripheral.discoverServicesAsync([UARTServiceUUID]);
	console.log("Service: " + uartService );
	const {characteristics} = await peripheral.discoverSomeServicesAndCharacteristicsAsync([UARTServiceUUID], [UARTRxUUID, UARTTxUUID] );
	console.log( "Got UART Characteristics: " + characteristics );
	// const {rx, tx} = await uartService.discoverCharacteristicsAsync( [UARTRxUUID, UARTTxUUID] );
	const deviceName = (await characteristics[0].readAsync());

	const rx = characteristics[1];
	const tx = characteristics[0];

	console.log( "rx: " + rx );
	console.log( "tx: " + tx );

	console.log( "subscribing" );
	rx.on( 'data', 	(data, isNotification) => { console.log( "Data=" + data.toString('hex') + ", isNotification: " + isNotification ); });
	rx.notify(true);
	// await rx.subscribeAsync();
	// rx.once( 'notify', state => { console.log( "notify state=" + state ); } )
/x
	const buffer = await rx.readAsync();
		// we get: 020104408403
		// 02 is start of short packet
		// 01 is packet length
		// 04 is the payload = COMM_GET_VALUES ?
		// 4084 is the checksup
		// 03 is the stop byte
	console.log( "byte=" + buffer.toString('hex'));
x/
	buffer = new Buffer.from([0x02, 0x01, 0x04, 0x40, 0x84, 0x03] );
	console.log( "writing" );
	await tx.writeAsync( buffer );
	console.log( "wrote" );

	const buffer2 = await rx.readAsync();
		// we get: 020104408403
		// 02 is start of short packet
		// 01 is packet length
		// 04 is the payload = COMM_GET_VALUES ?
		// 4084 is the checksup
		// 03 is the stop byte
	console.log( "buffer respose=" + buffer2.toString('hex'));


	console.log( "Read deviceName: " + deviceName  );
	// console.log( "Services: " + services );
	console.log( "Characteristics: " + characteristics );
	  await peripheral.disconnectAsync();
    // await noble.startScanningAsync([], false);
	  process.exit(0);
  // }
});
*/
module.exports = {
	VESC: VESC,
	Packet: Packet
}
