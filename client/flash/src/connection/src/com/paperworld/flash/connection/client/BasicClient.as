package com.paperworld.flash.connection.client
{
	import com.joeberkovitz.moccasin.service.IOperation;
	import com.paperworld.flash.api.connection.IRemoteSharedObject;
	import com.paperworld.flash.api.multiplayer.IClient;
	import com.paperworld.flash.api.multiplayer.IGroupMessage;
	import com.paperworld.flash.api.multiplayer.IMessage;
	import com.paperworld.flash.api.multiplayer.INetConnection;
	import com.paperworld.flash.api.multiplayer.IPlayerMessage;
	import com.paperworld.flash.connection.handshake.Handshake;
	import com.paperworld.flash.connection.messages.SendMessageOperation;
	import com.paperworld.flash.util.AbstractProcessor;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.SyncEvent;
	import flash.net.SharedObject;

	/**
	 * A simple implementation of the IClient interface. This client wraps a single Red5Connection/RemoteSharedObject
	 * pair. It uses the NetConnection to send messages to the server and the RemoteSharedObject to receive
	 * Synchronisation messages from the server.
	 */
	public class BasicClient extends EventDispatcher implements IClient
	{
		/**
		 * @private
		 */
		private var _id:String;
		
		/**
		 * The unique id assigned to this client's connection by the server.
		 */
		public function get id():String 
		{
			return _id;
		}
		
		/**
		 * @private
		 */
		public function set id(value:String):void
		{
			_id = value;
		}
		
		/**
		 * @private
		 */
		private var _connection:INetConnection;
		
		/**
		 * The underlying NetConnection this client uses to send/receive messages.
		 */
		public function get connection():INetConnection
		{
			return _connection;
		}
		
		/**
		 * @private.
		 */
		public function set connection(value:INetConnection):void 
		{
			_connection = value;
			connection.client = this;
			
			if (sharedObject)
			{
				sharedObject.connection = connection;
			}
		}
		
		private var _sharedObject:IRemoteSharedObject;
		
		public function get sharedObject():IRemoteSharedObject
		{
			return _sharedObject;
		}
		
		public function set sharedObject(value:IRemoteSharedObject):void 
		{
			if (value != null)
			{
				_sharedObject = value;
				
				if (connection)
				{
					sharedObject.connection = connection;
				}
				
				sharedObject.addEventListener(SyncEvent.SYNC, onSync);
			}
		}
		
		private var messageProcessors:Array = [];
				
		public function BasicClient(connection:INetConnection = null, sharedObject:IRemoteSharedObject = null)
		{
			super(this);
			
			this.connection = connection;
			this.sharedObject = sharedObject;
		}
		
		/**
		 * Begins the quick handshake procedure - extend the handshake class to 
		 * implement a custom handshake for your game.
		 */
		public function connect():IOperation 
		{
			trace("BasicClient connecting " + connection.rtmpURI);
			
			var handshake:IOperation = new Handshake(this);
			handshake.addEventListener(Event.COMPLETE, onConnectionEstablished);
			
			return handshake;
		}
		
		/**
		 * Once the connection with the server is established we need
		 * to set the connection's client property back to this object
		 * so we can catch incoming calls to receiveMessage.
		 */
		private function onConnectionEstablished(e:Event):void 
		{
			connection.client = this;
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
		
		/**
		 * Receives a message - either from the server or from a 
		 * SharedObject.SYNC event.
		 * 
		 * Iterate over all message handlers and let them process
		 * the message if they're able. We don't break on the first handler
		 * that can handle the message because we want all the handlers
		 * that are able to handle the message to do so.
		 */
		public function receiveMessage(message:IMessage):void 
		{
			for each (var processor:AbstractProcessor in messageProcessors)
			{
				if (processor.canProcess(message))
				{
					processor.process(message);
				}
			}
		}
		
		private function onSync(event:SyncEvent):void 
		{
			var changeList:Array = event.changeList;
			var so:SharedObject = sharedObject.sharedObject;
			
			for (var i:int; i < changeList.length; i++)
			{
				var id:String = changeList[i].name;
				
				var object:Object = so.data[id];
				var message:IMessage = IMessage(so.data[id]);

				if (message)
				{
					receiveMessage(message);
				}
			}
		}
		
		public function addMessageProcessor(processor:AbstractProcessor):void 
		{
			messageProcessors.push(processor);
		}
	}
}