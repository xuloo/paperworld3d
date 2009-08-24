package org.paperworld.flash.api.connection
{
	import com.joeberkovitz.moccasin.service.IOperation;
	import org.paperworld.flash.api.connection.messages.IGroupMessage;
	import org.paperworld.flash.api.connection.messages.IMessage;
	import org.paperworld.flash.api.connection.messages.IMessageProcessingService;
	import org.paperworld.flash.api.connection.messages.IPlayerMessage;
	
	public interface IClient extends IMessageProcessingService
	{
		function get connection():INetConnection;
		
		function set connection(value:INetConnection):void;
		
		function get sharedObject():ISharedObject;
		
		function set sharedObject(value:ISharedObject):void;
		
		function get id():String;
		
		function set id(value:String):void;
		
		function sendToServer(message:IMessage):IOperation;
		
		function sendToPlayer(message:IPlayerMessage):IOperation;
		
		function sendToGroup(message:IGroupMessage):IOperation;
		
		function connect():IOperation;
	}
}