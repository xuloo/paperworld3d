package com.paperworld.flash.multiplayer.connection.client
{
	import com.joeberkovitz.moccasin.service.IOperation;
	import com.paperworld.flash.api.multiplayer.IClient;
	import com.paperworld.flash.api.multiplayer.IGroupMessage;
	import com.paperworld.flash.api.multiplayer.IMessage;
	import com.paperworld.flash.api.multiplayer.INetConnection;
	import com.paperworld.flash.api.multiplayer.IPlayerMessage;
	import com.paperworld.flash.multiplayer.connection.RemoteSharedObject;
	import com.paperworld.flash.multiplayer.connection.messages.SendMessageOperation;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	public class PaperworldClient extends EventDispatcher implements IClient
	{
		private var _id:String;
		
		public function set id(value:String):void
		{
			_id = value;
		}
		
		private var _connection:INetConnection;
		
		public function get connection():INetConnection
		{
			return _connection;
		}
		
		public function set connection(value:INetConnection):void 
		{
			_connection = value;
			_connection.client = this;
		}
		
		private var _sharedObject:RemoteSharedObject;
		
		public function get sharedObject():RemoteSharedObject
		{
			return _sharedObject;
		}
		
		public function set sharedObject(value:RemoteSharedObject):void 
		{
			_sharedObject = value;
		}
		
		public function PaperworldClient(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		/**
		 * Begins the quick handshake procedure - extend the handshake class to 
		 * implement a custom handshake for your game.
		 */
		public function connect():IOperation 
		{
			return new Handshake(this);
		}
		
		public function sendToServer(message:IMessage):IOperation 
		{
			return _sendMessage(message);
		}
		
		public function sendToPlayer(message:IPlayerMessage):IOperation
		{
			return _sendMessage(message);
		}
		
		public function sendToGroup(message:IGroupMessage):IOperation 
		{
			return _sendMessage(message);
		}
		
		private function _sendMessage(message:IMessage):IOperation 
		{
			message.senderId = _id;
			
			return new SendMessageOperation(message, connection);
		}
		
		public function receiveMessage(message:IMessage):void 
		{
			
		}
	}
}