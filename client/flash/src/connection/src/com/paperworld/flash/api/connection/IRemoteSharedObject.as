package com.paperworld.flash.api.connection
{
	import com.paperworld.flash.api.multiplayer.INetConnection;
	
	import flash.events.IEventDispatcher;
	import flash.net.SharedObject;
	
	public interface IRemoteSharedObject extends IEventDispatcher
	{
		function get connection():INetConnection;
		
		function set connection(value:INetConnection):void;
		
		function get sharedObject():SharedObject;
	}
}