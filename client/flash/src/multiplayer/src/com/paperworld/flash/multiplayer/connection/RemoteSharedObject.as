package com.paperworld.flash.multiplayer.connection
{
	import flash.events.EventDispatcher;

	public class RemoteSharedObject extends EventDispatcher
	{
		private var _persistent:Boolean;
		
		public function get persistent():Boolean
		{
			return _persistent;
		}
		
		public function set persistent(value:Boolean):void 
		{
			_persistent = value;
		}
		
		private var _secure:Boolean;
		
		public function get secure():Boolean
		{
			return _secure;
		}
		
		public function set secure(value:Boolean):void 
		{
			_secure = value;
		}
		
		private var _connection:Red5Connection;
		
		public function get connection():Red5Connection
		{
			return _connection;
		}
		
		public function set connection(value:Red5Connection):void 
		{
			_connection = value;
		}
		
		public function RemoteSharedObject(name:String, persistent:Boolean, secure:Boolean)
		{
			super(this);
		}
		
	}
}