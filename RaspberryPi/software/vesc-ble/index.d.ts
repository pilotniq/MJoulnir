import EventEmitter from "node:events";

interface State {
    func: (packet: Packet, byte: number, context?: any) => void;
    context?: any;
}

export declare class Packet
{
    static Types: { [name: string]: number };

    invalid: boolean;
    isComplete: boolean;    
    type: number;
}

export declare class Packet_Values extends Packet
{
    temp_mos: number;
    temp_motor: number;
    current_motor: number;
    current_in: number;
    current_id: number;
    current_iq: number;
    duty: number;
    rpm: number;
    voltage_in: number;
    energy_ah: number;
    energy_charged_ah: number;
    energy_wh: number;
    energy_charged_wh: number;
    tachometer: number;
    tachometer_abs: number;
    fault: number;
    pid_pos_now: number;
    controller_id: number;
    temperature_mos1: number;
    temperature_mos2: number;
    temperature_mos3: number;
    vq: number;
}

export declare class Packet_CAN extends Packet
{
    id: number;
    isExtended: number;
    data: number[];
}

export declare class VESC extends EventEmitter
{
    static Types: { [name: string]: number };

    constructor();
    async ble_connect( ): Promise<void>;
    sendPacket( type: number, data: Buffer, withResponse: boolean ): Promise<void>;
    async getValues(): Promise<void>;
    sendCAN( id: number, data: Uint8Array, withResponse: boolean ): Promise<void>;
    // sendCANCharge( maxVoltage: number, maxCurrent: number, chargeOn: boolean ): void;
}
