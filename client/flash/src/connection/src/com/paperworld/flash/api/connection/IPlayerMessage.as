package com.paperworld.flash.api.connection
{
	public interface IPlayerMessage extends IMessage
	{
		function get playerId():String;
		
		function set playerId(value:String):void;
	}
}