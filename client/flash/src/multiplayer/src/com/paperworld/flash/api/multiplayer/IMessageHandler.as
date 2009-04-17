package com.paperworld.flash.api.multiplayer
{
	public interface IMessageHandler
	{
		function canHandleMessage(message:IMessage):Boolean;
		
		function handleMessage(message:IMessage):void;
	}
}