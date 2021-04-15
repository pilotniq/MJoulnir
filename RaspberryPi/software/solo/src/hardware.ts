import * as OnOff from 'onoff'

const prechargePin = new OnOff.Gpio( 22, 'out' )
const contactorPin = new OnOff.Gpio( 10, 'out' )
export const bmsFaultPin = new OnOff.Gpio( 25, 'in' )
export const switchPin = new OnOff.Gpio( 24, 'in' )
switchPin.setEdge('rising');

export function setPrecharge( value: OnOff.BinaryValue ): void
{
	prechargePin.writeSync( value );
}

export function setContactor( value: OnOff.BinaryValue ): void
{
	contactorPin.writeSync( value );
}
/*
module.exports = {
	setPrecharge: setPrecharge,
	setContactor: setContactor,
	switchPin: switchPin
}
*/