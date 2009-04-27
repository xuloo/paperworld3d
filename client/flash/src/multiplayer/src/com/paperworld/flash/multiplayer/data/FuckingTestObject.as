package com.paperworld.flash.multiplayer.data
{
	import com.paperworld.flash.util.IRegisteredClass;
	import com.paperworld.flash.util.Registration;
	
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;

	public class FuckingTestObject implements IExternalizable, IRegisteredClass
	{
		public var px:Number = 10.0;
		public var py:Number = 10.0;
		public var pz:Number = 10.0;
		public var ox:Number = 10.0;
		public var oy:Number = 10.0;
		public var oz:Number = 10.0;
		public var ow:Number = 10.0;
		
		public function FuckingTestObject()
		{
			Registration.registerClass(this);
		}

		public function writeExternal(output:IDataOutput):void
		{
			output.writeFloat(px);
			output.writeFloat(py);
			output.writeFloat(pz);
			output.writeFloat(ox);
			output.writeFloat(oy);
			output.writeFloat(oz);
			output.writeFloat(ow);
		}
		
		public function readExternal(input:IDataInput):void
		{
			px = input.readFloat();
			py = input.readFloat();
			pz = input.readFloat();
			ox = input.readFloat();
			oy = input.readFloat();
			oz = input.readFloat();
			ow = input.readFloat();
		}
		
		public function get aliasName():String
		{
			return "com.paperworld.java.impl.FuckingTestObject";
		}
		
	}
}