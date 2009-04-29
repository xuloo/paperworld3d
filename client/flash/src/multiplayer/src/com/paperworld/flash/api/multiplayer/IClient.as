package com.paperworld.flash.api.multiplayer
{
	import com.joeberkovitz.moccasin.service.IOperation;
	import com.paperworld.flash.api.connection.IRemoteSharedObject;
	
	public interface IClient extends IMessageProcessingService
	{
		function get connection():INetConnection;
		
		function set connection(value:INetConnection):void;
		
		function get sharedObject():IRemoteSharedObject;
		
		function set sharedObject(value:IRemoteSharedObject):void;
		
		function get id():String;
		
		function set id(value:String):void;
		
		function sendToServer(message:IMessage):IOperation;
		
		function sendToPlayer(message:IPlayerMessage):IOperation;
		
		function sendToGroup(message:IGroupMessage):IOperation;
		
		function connect():IOperation;
	}
}