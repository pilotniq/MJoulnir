import * as events from 'events';

export enum ChargerError {Hardware=0, OverTemperature=1, Battery=3, Communication=4}

// emits 'changed'
export interface Charger extends events.EventEmitter
{
	detected: boolean
	powered: boolean
	acc_charge_J: number
	output_voltage: number
	output_current: number
	errorBits: number
	
	setChargingParameters(max_votage: number, max_current: number, doCharge: boolean): void;
}
