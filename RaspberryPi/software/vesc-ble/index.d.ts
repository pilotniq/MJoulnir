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
    temp_mos_1: number;
    temp_mos_2: number;
    temp_mos_3: number;
    vq: number;
    vd: number;
}

export declare class Packet_CAN extends Packet
{
    id: number;
    isExtended: number;
    data: number[];
}

export interface VESCinterface extends EventEmitter
{
    async ble_connect( ): Promise<void>;
    async getValues(): Promise<void>;
    async getAppConf(): Promise<void>;
    sendCAN( id: number, data: Uint8Array, withResponse: boolean ): Promise<void>;
}

export declare class VESC extends EventEmitter implements VESCinterface
{
    static Types: { [name: string]: number };

    constructor();
    async ble_connect( ): Promise<void>;
    sendPacket( type: number, data: Buffer, withResponse: boolean ): Promise<void>;
    async getValues(): Promise<void>;
    async getAppConf(): Promise<void>;
    sendCAN( id: number, data: Uint8Array, withResponse: boolean ): Promise<void>;
    // sendCANCharge( maxVoltage: number, maxCurrent: number, chargeOn: boolean ): void;
}
