package com.paperworld.flash.multiplayer.connection.messages
{
	import com.joeberkovitz.moccasin.service.AbstractOperation;
	import com.paperworld.flash.api.multiplayer.IMessage;
	import com.paperworld.flash.api.multiplayer.INetConnection;
	
	import flash.events.Event;
	
	import mx.rpc.events.FaultEvent;

	public class SendMessageOperation extends AbstractOperation
	{
		private var _message:IMessage;
		
		private var _connection:INetConnection;
		
		public function SendMessageOperation(message:IMessage, connection:INetConnection)
		{
			super();
			
			_message = message;
			_connection = connection;
		}
		
		override public function execute():void 
		{
			_message.addEventListener(Event.COMPLETE, handleComplete);
			_message.addEventListener(FaultEvent.FAULT, handleError);
			
			_message.write(_connection);			
		}
		
		override public function get result():*
		{
			return _message.read();
		}
		
	}
}