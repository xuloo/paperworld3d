package com.paperworld.flash.api.multiplayer.messages
{
	import com.paperworld.flash.util.input.IInput;
	
	public interface IPlayerSyncMessage
	{
		function get objectId():String;
		function set objectId(id:String):void;
		
		function get input():IInput;	
		function set input(input:IInput):void;
	
		function get time():int;	
		function set time(time:int):void;
	}
}