import * as VESCble from "vesc-ble";

import * as BoatModel from "./boatModel"
import * as VESC from './vesc';

export class Charger
{
	vesc: VESC.VESCtalker;
	model: BoatModel.BoatModel;
	detected: boolean;
	max_voltage: number;
	max_current: number;
	do_charge = false;

	sender?: NodeJS.Timer; // an Timer
	recvTimeout?: NodeJS.Timer; // a Timer

	last_power_W = 0;
	last_update_time?: Date;

	constructor( vesc: VESC.VESCtalker, model: BoatModel.BoatModel )
	{
		this.vesc = vesc;
		this.model = model;
		this.detected = false;
		this.max_voltage = 0;
		this.max_current = 0;
		this.vesc.on( 'CAN', this.receiveCAN.bind(this) );
	}

	public setChargingParameters( max_voltage: number, max_current: number, 
		doCharge: boolean ): void
	{
		this.max_voltage = max_voltage;
		this.max_current = max_current;
		this.do_charge = doCharge

		this.model.charger.updateCharging( max_voltage, max_current, doCharge );
	}

	receiveCAN( packet: VESCble.Packet_CAN ): void
	{
		const now = new Date();

		if( packet.id == 0x18ff50e5 ) // Charger status
		{
			const charger_model = this.model.charger;

			if( this.detected )
				clearTimeout( this.recvTimeout! );

			const output_voltage = ((packet.data[0] << 8) | packet.data[1]) / 10;
			const output_current = ((packet.data[2] << 8) | packet.data[3]) / 10;
			const status = packet.data[4];

			const hardware_good = (status & 1) == 0;
			const temperature_good = (status & 2) == 0;
			const input_voltage_good = (status & 4) == 0;
			const battery_detect_good = (status & 8) == 0;
			const communication_good = (status & 16) == 0;

			const power_W = output_voltage * output_current;

			let dt: number;

			if( this.last_update_time === undefined )
				dt = 0.5
			else
				dt = (now.getTime() - this.last_update_time.getTime()) / 1000.0

			this.last_update_time = now;
			
			const average_power = (power_W + this.last_power_W)
			const delta_J = average_power * dt;

			charger_model.update1( output_voltage, output_current, hardware_good, temperature_good,
				input_voltage_good, battery_detect_good, communication_good, delta_J );

			// start timer for detecting loss off communication
			// if no packet received in 2.5 seconds (should come every second), consider charger down
			this.recvTimeout = setTimeout( this.recvTimeoutFunc.bind(this), 2500 );

			if( !this.detected )
			{
				console.log( "Charger detected!" );
				// start timer for sending voltage/current
				this.sendMaxCharging(); // setInterval( this.sendValues.bind(this), 1000 );
			}
			this.detected = true;
		}
	}

	recvTimeoutFunc(): void
	{
		console.log( "Charger receive timeout" );
		this.last_update_time = undefined;
		this.model.charger.lostConnection();
		this.detected = false;
	}

	async sendMaxCharging(): Promise<void>
	{
		const data = new Uint8Array(8);

		this.sender = undefined;

		const v10 = Math.floor(this.max_voltage * 10);
		const c10 = Math.floor(this.max_current * 10);

		data[0] = (v10 >> 8) & 0xff;
		data[1] = (v10 & 0xff);
		data[2] = (c10 >> 8) & 0xff;
		data[3] = (c10 & 0xff);
		data[4] = this.do_charge ? 0 : 1;

		// console.log( "Sending CAN to charger" );

		// since we send this every second, don't require responses.
		return this.vesc.sendCAN( 0x1806E5F4, data, false )
			.then( () => { 
				// console.log( "Sent CAN to charger" );
				this.sender = setTimeout( this.sendMaxCharging.bind(this), 1000 );
			} );
	}
}
