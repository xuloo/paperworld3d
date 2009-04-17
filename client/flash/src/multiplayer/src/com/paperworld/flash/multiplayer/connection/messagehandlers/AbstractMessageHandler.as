package com.paperworld.flash.multiplayer.connection.messagehandlers
{
	import com.paperworld.flash.api.multiplayer.IMessage;
	import com.paperworld.flash.api.multiplayer.IMessageHandler;
	import com.paperworld.flash.core.game.IGame;

	public class AbstractMessageHandler implements IMessageHandler
	{
		private var _messageTypes:Array = [];
		
		protected var game:IGame;
		
		public function AbstractMessageHandler(game:IGame, messageTypes:Array)
		{
			this.game = game;
			
			_messageTypes = _messageTypes.concat(messageTypes);
		}
		
		public function addMessageType(messageType:Class):void 
		{
			_messageTypes.push(messageType);
		}

		public function canHandleMessage(message:IMessage):Boolean
		{
			for each (var messageType:Class in _messageTypes)
			{
				if (message is messageType)
				{
					return true;
				}
			}
			
			return false;
		}
		
		public function handleMessage(message:IMessage):void
		{
		}
		
	}
}