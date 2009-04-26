package com.paperworld.flash.api.multiplayer.messages
{
	import com.paperworld.flash.multiplayer.data.State;
	import com.paperworld.flash.util.input.IInput;
	
	public interface ISynchroniseCreateMessage
	{
		function get playerId():String;
		function set playerId(value:String):void;
		
		function get objectId():String;
		function set objectId(value:String):void;
		
		function get input():IInput;
		function set input(value:IInput):void;
		
		function get state():State;
		function set state(value:State):void;
	}
}