package com.paperworld.flash.multiplayer.connection.messages
{
	import com.paperworld.flash.api.multiplayer.INetConnection;
	import com.paperworld.flash.api.multiplayer.ISynchronisedAvatar;
	

	public class RequestIdMessage extends Red5Message
	{		
		override public function get command():String 
		{
			return "multiplayer.getAvatarId";
		}
		
		private var _uniqueId:String;
		
		public function RequestIdMessage()
		{
			super();
		}
		
		override public function write(connection:INetConnection):void
		{
			connection.call(command, responder, senderId);
		}
		
		override public function onResult(result:Object):void
		{
			_uniqueId = String(result);
		}
		
		override public function read():* 
		{
			return _uniqueId;
		}
	}
}