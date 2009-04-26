package com.paperworld.flash.multiplayer.connection.handshake
{
	import com.paperworld.flash.api.multiplayer.INetConnection;
	
	import flash.net.Responder;
	
	import org.springextensions.actionscript.mvcs.service.operation.AbstractOperation;

	public class EchoNetObjectOperation extends AbstractOperation
	{
		private var _connection:INetConnection;
		
		private var _command:String;
		
		private var _object:*;
		
		public function EchoNetObjectOperation(connection:INetConnection, command:String, object:*)
		{
			super(this);
			
			_connection = connection;
			_command = command;
			_object = object;
		}
		
		override public function execute():void
		{
			trace("echoing " + _connection + " to server");
			_connection.call(_command, new Responder(dispatchResult, dispatchError), _object);
		}
		
	}
}