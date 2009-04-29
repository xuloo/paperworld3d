package com.paperworld.flash.api.connection
{
	import com.paperworld.flash.util.AbstractProcessor;
	
	import flash.events.IEventDispatcher;
	
	public interface IMessageProcessingService extends IEventDispatcher
	{
		function receiveMessage(message:IMessage):void;
		
		function addMessageProcessor(processor:AbstractProcessor):void;
	}
}