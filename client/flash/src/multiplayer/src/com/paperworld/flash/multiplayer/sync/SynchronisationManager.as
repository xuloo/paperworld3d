package com.paperworld.flash.multiplayer.sync
{
	import com.joeberkovitz.moccasin.service.IOperation;
	import com.paperworld.flash.api.multiplayer.IClient;
	import com.paperworld.flash.api.multiplayer.IMessage;
	import com.paperworld.flash.api.multiplayer.IMessageHandler;
	import com.paperworld.flash.api.multiplayer.ISyncManager;
	import com.paperworld.flash.api.multiplayer.ISynchronisedAvatar;
	import com.paperworld.flash.multiplayer.connection.messages.RequestIdMessage;
	import com.paperworld.flash.util.input.IInput;
	
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	public class SynchronisationManager implements ISyncManager	
	{
		private var _messageHandlers:Array;
		
		private var _client:IClient;
		
		private var _batchedMoves:Array = [];
		
		private var _waitingForId:Dictionary = new Dictionary();
		
		public function set client(value:IClient):void
		{
			_client = value;
		}
		
		public function SynchronisationManager()
		{
		}
		
		public function registerMessageHandler(messageHandler:IMessageHandler):void 
		{
			_messageHandlers.push(messageHandler);
		}
		
		/**
		 * Register an object that this client will have authority over.
		 * 
		 * Before the object can be synchronised across clients it must be
		 * given a unique id that identifies it. This unique id is given
		 * by the server. So we first send this request message. When it's
		 * received we can start sending synchronisation message for this avatar.
		 */
		public function register(avatar:ISynchronisedAvatar):void 
		{
			// Create the message.
			var message:IMessage = new RequestIdMessage();
			
			// Add the avatar to the waiting list, using the message as the key.
			_waitingForId[message] = avatar;
			
			// Send the message.
			var sendOperation:IOperation = _client.sendToServer(message);
			sendOperation.addEventListener(Event.COMPLETE, onIdRequestComplete);
			sendOperation.execute();
		}
		
		public function unRegister(avatar:ISynchronisedAvatar):void 
		{
			
		}
		
		/**
		 * An id request has completed. We have received a unique id for an
		 * avatar on the server. We apply the id to the avatar and remove
		 * the avatar from the waiting list.
		 */
		protected function onIdRequestComplete(event:Event):void 
		{
			// Get the message from the completed operation.
			var message:IMessage = IOperation(event.target).result as IMessage;
			
			// Set the id on the avatar that it was requested for.
			ISynchronisedAvatar(_waitingForId[message]).id = message.read();
			
			// Remove the avatar from the waiting list now that it has a unique id.
			delete _waitingForId[message];
		}
		
		public function handleAvatarMove(id:String, input:IInput):void
		{
			
		}
	}
}