package com.paperworld.flash.multiplayer.connection.client
{
	import com.joeberkovitz.moccasin.service.AbstractOperation;
	import com.paperworld.flash.api.multiplayer.IClient;
	import com.paperworld.flash.api.multiplayer.INetConnection;
	import com.paperworld.flash.multiplayer.connection.events.Red5Event;
	
	public class Handshake extends AbstractOperation
	{
		private var _client:IClient;
		
		public function Handshake(client:IClient)
		{
			_client = client;
		}
		
		override public function execute():void 
		{
			var connection:INetConnection = _client.connection;
			connection.client = this;
			connection.addEventListener(Red5Event.CONNECTED, handleComplete);
			connection.addEventListener(Red5Event.REJECTED, handleError);
			connection.connect(connection.uri);
		}
		
		public function setClientID(id:String):void 
		{
			_client.id = id;
		}
	}
}