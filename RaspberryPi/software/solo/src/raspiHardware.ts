import * as OnOff from 'onoff'
import { LowLevelHardware } from './lowLevelHardware'


export class RaspiHardware implements LowLevelHardware
{
	readonly prechargePin = new OnOff.Gpio( 22, 'out' )
	readonly contactorPin = new OnOff.Gpio( 10, 'out' )
	readonly bmsFaultPin = new OnOff.Gpio( 25, 'in' )
	readonly switchPin = new OnOff.Gpio( 24, 'in' )

	constructor()
	{
		this.switchPin.setEdge('rising');
	}
	setPrecharge( value: boolean ): void
	{
		this.prechargePin.writeSync( value ? 1 : 0)
	}

	setContactor( value: boolean ): void
	{
		console.log( "RaspiHardware: setContactor( " + value + " )" )
		this.contactorPin.writeSync( value ? 1 : 0)
	}

}
/*
export function setPrecharge( value: OnOff.BinaryValue ): void
{
	prechargePin.writeSync( value );
}

export function setContactor( value: OnOff.BinaryValue ): void
{
	contactorPin.writeSync( value );
}
*/
/*
module.exports = {
	setPrecharge: setPrecharge,
	setContactor: setContactor,
	switchPin: switchPin
}
*/
