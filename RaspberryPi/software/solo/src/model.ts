// import { EventEmitter } from "events";
import * as events from 'events';
// import { TypedEmitter } from 'tiny-typed-emitter';
/*
interface TypedEventEmitter<T> {
  on<K extends keyof T>(s: K, listener: (v: T[K]) => void);
  // and so on for each method
}
*/
interface ModelAttributeEvents {
	'changed': () => void;
}

export class ModelAttribute extends events.EventEmitter // TypedEmitter<ModelAttributeEvents> // events.EventEmitter
{
	public isValid = false;
	public updateTime?: Date;

	public constructor() 
	{
		super();
	}

	public signalUpdated(): void
	{
		this.updateTime = new Date();
		this.emit('changed');
	}

	public onChanged( callback: () => void ): void
	{
		this.on( 'changed', callback );
	}

	public unOnChanged( callback: () => void ): void
	{
		this.removeListener( 'changed', callback );
	}
}

export class Model
{
}
