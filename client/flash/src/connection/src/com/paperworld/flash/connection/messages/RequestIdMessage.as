package com.paperworld.flash.connection.messages
{
	import com.paperworld.flash.api.multiplayer.ISynchronisedAvatar;
	

	public class RequestIdMessage extends BaseMessage
	{		
		override public function get aliasName():String
		{
			return "com.paperworld.java.impl.message.RequestIdMessage";
		}
		
		override public function get command():String 
		{
			return "multiplayer.receiveMessage";
		}
		
		private var _uniqueId:String;
		
		public function RequestIdMessage()
		{
			super();
		}
		
		override public function onResult(result:Object):void
		{
			_uniqueId = String(result);
			
			super.onResult(result);
		}
		
		override public function read():* 
		{
			return _uniqueId;
		}
	}
}