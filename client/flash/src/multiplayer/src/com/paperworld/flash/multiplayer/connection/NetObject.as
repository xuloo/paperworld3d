package com.paperworld.flash.multiplayer.connection
{
	import com.paperworld.flash.util.IRegisteredClass;
	import com.paperworld.flash.util.Registration;
	
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;

	public class NetObject implements IExternalizable, IRegisteredClass
	{
		public function get aliasName():String
		{
			return "com.paperworld.java.impl.NetObject";
		}
		
		public function NetObject()
		{
			Registration.registerClass(this);
		}

		public function writeExternal(output:IDataOutput):void
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
		}	
	}
}