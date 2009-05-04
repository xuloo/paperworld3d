package com.paperworld.flash.multiplayer.messages
{
	import com.paperworld.flash.api.multiplayer.messages.IServerSyncMessage;
	import com.paperworld.flash.multiplayer.data.State;
	
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	
	public class ServerSyncMessage extends PlayerSyncMessage implements IServerSyncMessage
	{
		override public function get aliasName():String
		{
			return "com.paperworld.java.impl.message.ServerSyncMessage";
		}
		
		private var _state:State = new State();
		
		public function get state():State
		{
			return _state;
		}
		
		public function set state(value:State):void
		{
			_state = value;
		}
		
		public function ServerSyncMessage()
		{
			super();
		}
		
		/**
		 * Handles serialising this object for sending across to the server.
		 */
		override public function writeExternal(output:IDataOutput):void 
		{
			super.writeExternal(output);
			
			output.writeObject(state);
		}
		
		/**
		 * Handles deserialising this object when received from the server.
		 */
		override public function readExternal(input:IDataInput):void 
		{
			super.readExternal(input);
			
			state = input.readObject();
		}
	}
}