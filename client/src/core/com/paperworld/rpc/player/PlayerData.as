package com.paperworld.rpc.player
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;

	public class PlayerData implements IExternalizable
	{
		public var username:String;
		
		public var thumbNail:String;
		
		public function PlayerData()
		{
		}

		public function writeExternal(output:IDataOutput):void
		{
			output.writeUTF(username);
			output.writeUTF(thumbNail);
		}
		
		public function readExternal(input:IDataInput):void
		{
			username = input.readUTF();
			thumbNail = input.readUTF();
		}
		
	}
}