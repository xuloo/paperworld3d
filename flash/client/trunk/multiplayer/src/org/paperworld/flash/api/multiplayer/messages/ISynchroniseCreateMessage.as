package org.paperworld.flash.api.multiplayer.messages
{
	import org.paperworld.flash.api.IInput;
	import org.paperworld.flash.api.IState;
	
	public interface ISynchroniseCreateMessage
	{
		function get playerId():String;
		function set playerId(value:String):void;
		
		function get objectId():String;
		function set objectId(value:String):void;
		
		function get input():IInput;
		function set input(value:IInput):void;
		
		function get state():IState;
		function set state(value:IState):void;
	}
}