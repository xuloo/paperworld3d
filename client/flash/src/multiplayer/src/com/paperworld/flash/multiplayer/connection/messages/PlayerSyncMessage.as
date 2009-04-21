package com.paperworld.flash.multiplayer.connection.messages
{
	import com.paperworld.flash.util.input.IInput;
	
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	
	public class PlayerSyncMessage extends BaseMessage
	{
		override public function get aliasName():String
		{
			return "com.paperworld.java.impl.message.PlayerSyncMessage";
		}
		
		private var _time:int;
		
		public function get time():int 
		{
			return _time;
		}
		
		public function set time(value:int):void 
		{
			_time = value;
		}
		
		public function PlayerSyncMessage()
		{
			super();
		}
		
		private var _input:IInput;
		
		public function get input():IInput
		{
			return input;
		}
		
		public function set input(value:IInput):void 
		{
			_input = value;
		}
		
		/**
		 * Handles serialising this object for sending across to the server.
		 */
		override public function writeExternal(output:IDataOutput):void 
		{
			super.writeExternal(output);
			
			output.writeInt(time);
			output.writeObject(input);
		}
		
		/**
		 * Handles deserialising this object when received from the server.
		 */
		override public function readExternal(input:IDataInput):void 
		{
			super.readExternal(input);
			
			time = input.readInt();
			this.input = input.readObject();
		}
	}
}