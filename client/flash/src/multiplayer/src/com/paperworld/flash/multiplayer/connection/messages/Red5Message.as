package com.paperworld.flash.multiplayer.connection.messages
{
	import com.paperworld.flash.api.multiplayer.IMessage;
	import com.paperworld.flash.api.multiplayer.INetConnection;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.Responder;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	
	import mx.rpc.events.FaultEvent;

	/**
	 * Base class for messages sent to a Red5 server using a NetConnection.
	 */
	public class Red5Message extends EventDispatcher implements IMessage, IExternalizable
	{
		private var _senderId:String;
		
		public function set senderId(value:String):void 
		{
			_senderId = value;
		}
		
		public function get senderId():String 
		{
			return _senderId;
		}
		
		private var _command:String;
		
		public function get command():String
		{
			return _command;
		}
		
		public function set command(value:String):void 
		{
			_command = value;
		}
		
		private var _responder:Responder = new Responder(onResult, onFault);
		
		public function get responder():Responder 
		{
			return _responder;
		}
		
		public function set responder(value:Responder):void
		{
			_responder = value;
		}
		
		public function Red5Message()
		{
		}

		public function write(connection:INetConnection):void
		{
		}
		
		public function read():*
		{
			return null;
		}
		
		public function onResult(o:Object):void 
		{
			messageAcknowledged();
		}
		
		public function onFault(o:Object):void 
		{
			dispatchEvent(new FaultEvent(FaultEvent.FAULT));
		}
		
		public function messageSent():void 
		{
			
		}
		
		public function messageConfirmed():void 
		{
			
		}
		
		public function messageAcknowledged():void 
		{
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		/**
		 * Handles serialising this object for sending across to the server.
		 */
		public function writeExternal(output:IDataOutput):void 
		{
			output.writeUTF(senderId);
		}
		
		/**
		 * Handles deserialising this object when received from the server.
		 */
		public function readExternal(input:IDataInput):void 
		{
			senderId = input.readUTF();
		}
		
	}
}