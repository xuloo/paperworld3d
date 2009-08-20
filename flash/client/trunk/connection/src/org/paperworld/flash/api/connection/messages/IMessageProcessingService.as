package org.paperworld.flash.api.connection.messages
{
	import org.paperworld.flash.utils.IProcessor;
	
	import flash.events.IEventDispatcher;
	
	public interface IMessageProcessingService extends IEventDispatcher
	{
		function receiveMessage(message:IMessage):void;
		
		function addMessageProcessor(processor:IProcessor):void;
	}
}