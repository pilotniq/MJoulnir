'use strict';

const assert = require('assert').strict;

const registers = require('./registers');

var bitField1 = new registers.BitField( "BIT_FIELD_1", "Bit Field 1 for testing", 2, 3, 0, [
	new registers.BitFieldValue( "EMPTY", "Like a circle", 0 ),
	new registers.BitFieldValue( "DOT", "Like a point", 1 ),
	new registers.BitFieldValue( "LINE", "Like a circle", 2 ),
	new registers.BitFieldValue( "TRIANGLE", "three edges", 3 ),
	new registers.BitFieldValue( "SQUARE", "Four corners", 4 ),
	new registers.BitFieldValue( "PENTAGON", "Like the military's place", 5 ),
	new registers.BitFieldValue( "HEXAGON", "Six sides", 6 ),
	new registers.BitFieldValue( "SEPTAGON", "Unusual", 7 ) ] );


var bitField2 = new registers.BitField( "BIT_FIELD_2", "Bit Field 2 for testing", 2, 0, 0, [] );

var register1 = new registers.Register( "Register1", "A great register", 8, [bitField1, bitField2] );

register1.set( register1.BIT_FIELD_1, register1.BIT_FIELD_1.TRIANGLE );

assert.equal( bitField1.getSetMask(), 0x1c /* 11100 = 0x1c */ );
assert.equal( register1.value, 0x0c ); /* 1100 = 0xc */
