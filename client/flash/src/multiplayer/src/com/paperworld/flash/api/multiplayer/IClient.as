package com.paperworld.flash.api.multiplayer
{
	import com.joeberkovitz.moccasin.service.IOperation;
	import com.paperworld.flash.multiplayer.connection.RemoteSharedObject;
	
	import flash.events.IEventDispatcher;
	
	public interface IClient extends IEventDispatcher
	{
		function get connection():INetConnection;
		
		function set connection(value:INetConnection):void;
		
		function get sharedObject():RemoteSharedObject;
		
		function set sharedObject(value:RemoteSharedObject):void;
		
		function set id(value:String):void;
		
		function sendToServer(message:IMessage):IOperation;
		
		function sendToPlayer(message:IPlayerMessage):IOperation;
		
		function sendToGroup(message:IGroupMessage):IOperation;
	}
}