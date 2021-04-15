const assert = require('assert').strict;

class Register
{
	// bitfields: array of BitField
	constructor( address, name, description, bit_count, bitfields )
	{
		this.address = address;
		this.name = name;
		this.description = description;
		this.bit_count = bit_count;
		this.fields = bitfields;
		this.value = 0;
		
		bitfields.forEach( field => { this[field.name] = field; } );
	}

	addField( bitField )
	{
		this.fields.push( bitField );
		this[bitField.name] = bitField;
	}

	set( field, fieldValue )
	{
		this.value = field.setValue( this.value, fieldValue );
	}

	set_value( value )
	{
		this.value = value;
	}

	get_string_value()
	{
		let result = "";

		this.fields.forEach( field => result += field.name + " = " + field.getStringValue( this.value ) + ", " );

		return result;
	}
}

class BitField
{
	constructor( name, description, firstBit, bitCount, defaultValue, values )
	{
		this.name = name;
		this.description = description;
		this.first_bit = firstBit;
		this.bit_count = bitCount;
		this.values = values;
		this.valueMap = {}
		values.forEach( value => { this[value.name] = value; } );
		values.forEach( value => { this.valueMap[value.value] = value; } );
	}

	addValue( name, bitValue )
	{
		this.values[ name ] = bitValue;
	}

	getSetMask()
	{
		console.log( "this.bit_count = " + this.bit_count );
		console.log( "this.bit_count = " + this.first_bit );

		return ((2 ** this.bit_count) -1) << this.first_bit;
	}

	getClearMask()
	{
		let allOnes = 2 ** (this.first_bit + this.bit_count) - 1;
		return allOnes & ~this.getSetMask();
	}

	setValue( prevValue, bitFieldValue )
	{
		
		prevValue = prevValue & this.getClearMask()
		prevValue = prevValue | (bitFieldValue.value << this.first_bit)

		return prevValue;
	}

	getStringValue( value )
	{
		let fieldValue = (value & this.getSetMask()) >> this.first_bit;
		if( fieldValue in this.valueMap )
			return this.valueMap[ fieldValue ].name;
		else
			return "invalid (" + fieldValue + ")";
	}
}

class BitFieldValue
{
	constructor( name, description, value )
	{
		this.name = name;
		this.description = description;
		this.value = value;
	}
}

module.exports = { Register, BitField, BitFieldValue }
