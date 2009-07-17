package com.paperworld.flash.api.connection.messages
{
	import com.paperworld.flash.util.IProcessor;
	
	import flash.events.IEventDispatcher;
	
	public interface IMessageProcessingService extends IEventDispatcher
	{
		function receiveMessage(message:IMessage):void;
		
		function addMessageProcessor(processor:IProcessor):void;
	}
}