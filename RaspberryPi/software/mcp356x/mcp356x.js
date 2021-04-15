'use strict';

const Registers = require('./registers');
const SPI = require('spi-device');

const REGISTER_CONFIG0 = new Registers.Register( 0x1, "CONFIG0", "Configuration 0", 8, [
	new Registers.BitField( "CLK_SEL", "Clock Selection", 4, 2, 0, [ 
		new Registers.BitFieldValue( "EXTERNAL_DIGITAL_DEFAULT", "External digital clock (default)", 0 ),
		new Registers.BitFieldValue( "EXTERNAL_DIGITAL", "External digital clock", 1 ),
		new Registers.BitFieldValue( "INTERNAL_CLOCK_NO_OUTPUT", "Internal clock is selected and no clock output is present on the CLK pin", 2 ),
		new Registers.BitFieldValue( "INTERNAL_CLOCK_OUTPUT", "Internal clock is selected and AMCLK is present on the analog master clock output pin", 3 )
	]),
	new Registers.BitField( "CS_SEL", "Current Source/Sink Selection Bits for Sensor Bias (source on VIN+/sink on VIN-)", 2, 2, 0, [
		new Registers.BitFieldValue( "15_UA", "15 µA is applied to the ADC inputs", 0 ),
		new Registers.BitFieldValue( "3.7_UA", "External digital clock", 1 ),
		new Registers.BitFieldValue( "INTERNAL_CLOCK_NO_OUTPUT", "Internal clock is selected and no clock output is present on the CLK pin", 2 ),
		new Registers.BitFieldValue( "INTERNAL_CLOCK_OUTPUT", "Internal clock is selected and AMCLK is present on the analog master clock output pin", 3 )
	]),
	new Registers.BitField( "ADC_MODE", "ADC Operating Mode Selection", 0, 2, 0, [
		new Registers.BitFieldValue( "SHUTDOWN_DEFAULT", "Shutdown (Default)", 0 ),
		new Registers.BitFieldValue( "SHUTDOWN", "Shutdown", 1 ),
		new Registers.BitFieldValue( "STANDBY", "Standby", 2 ),
		new Registers.BitFieldValue( "CONVERSION", "Conversion mode", 3 ),
	])
])

const REGISTER_CONFIG1 = new Registers.Register( 0x2, "CONFIG1", "Configuration 1", 8, [
	new Registers.BitField( "PRE", "Prescaler Value Selection for AMCLK", 6, 2, 0, [ 
		new Registers.BitFieldValue( "MCLK", "No Prescaler (default)", 0 ),
		new Registers.BitFieldValue( "MCLK/2", "/2 prescaler", 1 ),
		new Registers.BitFieldValue( "MCLK/4", "/4 prescaler", 2 ),
		new Registers.BitFieldValue( "MCLK/8", "/8 prescaler", 3 )
	]),
	new Registers.BitField( "OSR", "Oversampling Ratio for Delta-Sigma A/D Conversion", 2, 4, 3, [
		new Registers.BitFieldValue( "32", "OSR: 32", 0 ),
		new Registers.BitFieldValue( "64", "OSR: 64", 1 ),
		new Registers.BitFieldValue( "128", "OSR: 128", 2 ),
		new Registers.BitFieldValue( "256", "OSR: 256", 3 ),
		new Registers.BitFieldValue( "512", "OSR: 512", 4 ),
		new Registers.BitFieldValue( "1024", "OSR: 1024", 5 ),
		new Registers.BitFieldValue( "2048", "OSR: 2048", 6 ),
		new Registers.BitFieldValue( "4096", "OSR: 4096", 7 ),
		new Registers.BitFieldValue( "8192", "OSR: 8192", 8 ),
		new Registers.BitFieldValue( "16384", "OSR: 16384", 9 ),
		new Registers.BitFieldValue( "20480", "OSR: 20480", 10 ),
		new Registers.BitFieldValue( "24576", "OSR: 24576", 11 ),
		new Registers.BitFieldValue( "40960", "OSR: 40960", 12 ),
		new Registers.BitFieldValue( "49152", "OSR: 49152", 13 ),
		new Registers.BitFieldValue( "81920", "OSR: 81920", 14 ),
		new Registers.BitFieldValue( "98304", "OSR: 98304", 15 )
	])
])

const REGISTER_CONFIG2 = new Registers.Register( 0x3, "CONFIG2", "Configuration 2", 8, [
	new Registers.BitField( "BOOST", "ADC Bias Current Selection", 6, 2, 2, [ 
		new Registers.BitFieldValue( "0.5", " ADC channel has current x 0.5", 0 ),
		new Registers.BitFieldValue( "0.66", "ADC channel has current x 0.66", 1 ),
		new Registers.BitFieldValue( "1", "ADC channel has current x 1 (default)", 2 ),
		new Registers.BitFieldValue( "2", "ADC channel has current x 2", 3 ),
	]),
	new Registers.BitField( "GAIN", "ADC Gain Selection", 3, 3, 1, [
		new Registers.BitFieldValue( "1/3", "Gain is x1/3", 0 ),
		new Registers.BitFieldValue( "1", "Gain is x1 (default)", 1 ),
		new Registers.BitFieldValue( "2", "Gain is x2", 2 ),
		new Registers.BitFieldValue( "4", "Gain is x4", 3 ),
		new Registers.BitFieldValue( "8", "Gain is x8", 4 ),
		new Registers.BitFieldValue( "16", "Gain is x16", 5 ),
		new Registers.BitFieldValue( "32", "Gain is x32 (x16 analog, x2 digital)", 6 ),
		new Registers.BitFieldValue( "64", "Gain is x64 (x16 analog, x4 digital)", 7 )
	]),
	new Registers.BitField( "AZ_MUX", "Auto-Zeroing MUX Setting", 2, 1, 0, [
		new Registers.BitFieldValue( "ENABLED", "ADC auto-zeroing algorithm is enabled. This setting multiplies the conversion time by two and" +
				" does not allow Continuous Conversion mode operation (which is then replaced by a series of " +
				"consecutive One-Shot mode conversions).", 1 ),
		new Registers.BitFieldValue( "DISABLED", "Analog input multiplexer auto-zeroing algorithm is disabled (default)", 0 )
	])
])


		
// CONFIG0.set( CONFIG0.CLK_SEL, CONFIG0.CLK_SEL.INTERNAL_CLOCK_NO_OUTPUT );

module.exports = class MCP356x
{
	constructor( spiBusNumber, spiDeviceNumber, address, spiBitsPerSecond )
	{
		this._spiBusNumber = spiBusNumber;
		this._spiDeviceNumber = spiDeviceNumber;
		this._spiBitsPerSecond = spiBitsPerSecond;
		this._config0 = 0x80;
		this._config1 = 0x0c; // 00001100 = 0x0C
		this._config2 = 0x8b; // 10001011 = 0x8b
		this._config3 = 0x00; // 00000000 = 0x00
		this._irq_register = 0x03;  // 00000011 = 0x03
		this._mux_register = 0x01;  // 00000001 = 0x01
		this._scan_register = 0x000000; // 0000 0000 
		this._timer_register = 0x00000;
		this._offsetcal = 0x000000;
		this.gaincal = 0x80000;
		this.address = address;
	}

	/* async */ open()
	{
		this._device = SPI.openSync( this._spiBusNumber, this._spiDeviceNumber );
	}

	set_clock( clock )
	{}
	async read( register ) {
		// assert( this.address >= 0 );
		// assert( this.address < 4 );

		let cmd = this.address << 6 | 
			register.address << 2 |
			0x01;
		let byte_count = 1 + register.bit_count / 8;
		let sendBuffer = Buffer.alloc( byte_count );
		sendBuffer[0] = cmd;

		const message = [{
			sendBuffer: sendBuffer, // Sent to read register 2 (config1)
    			receiveBuffer: Buffer.alloc(byte_count),              // Raw data read from channel 5
    			byteLength: byte_count,
    			speedHz: this._spiBitsPerSecond
		}]

		this._device.transferSync( message );

		let result = 0;
		
		for( var i = 1; i < byte_count; i++ )
		{
			const byte = message[0].receiveBuffer[i];
			console.log( "byte=" + byte );
			result = result | (message[0].receiveBuffer[i] << (8 * (byte_count - i - 1)))
		}

		console.log( "result=" + result );
		register.set_value( result );
	}

	
}

let mcp = new module.exports( 1, 0, 1, 10000000 );
mcp.open()
mcp.read( REGISTER_CONFIG1 );
console.log( "Config1: " + REGISTER_CONFIG1.get_string_value() );
