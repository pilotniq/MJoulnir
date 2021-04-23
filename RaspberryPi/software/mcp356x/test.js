const SPI = require('spi-device');

const message = [{
	// first byte: 01 00 10 01 = 0x49
	// means: device address = 1
	// register address = 0010 = 2
	// command type = 01 = static read of register
	sendBuffer: Buffer.from([0x19, 0x00]), // Sent to read register 2 (config1)
    	receiveBuffer: Buffer.alloc(2),              // Raw data read from channel 5
    	byteLength: 2,
    	speedHz: 2 // Use a low bus speed to get a good reading from the TMP36
}]

// i = 1 gives response!
// response is 23, 12. = 0001 0111 0000 1100
// means device address = 01
// register address top bit = 0
// nDR status = 1
// nCRCREG = 1
// nPOR = 1
//
// config1 is:
// prescaler = 00 = MCLK (default)
// osr = 0011 = 256 (default)
// reserved = 00
// YES! 

for( i = 0; i < 4; i++ )
{
	message[0].sendBuffer[0] = i << 6 | 0x09;

	device = SPI.openSync( 1, 0 )
	// device.setOptionsSync( { mode: SPI.MODE0 } );
	device.transferSync( message )
	console.log( "i=" + i + ", response " + message[0].receiveBuffer[0] + ", " + message[0].receiveBuffer[1] )
}
