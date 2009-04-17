package com.paperworld.flash.api.multiplayer
{	
	import flash.events.IEventDispatcher;
	import flash.net.Responder;
	
	public interface INetConnection extends IEventDispatcher
	{
		function connect(command:String, ...args):void;
		
		function call(command:String, responder:Responder, ...args):void;
		
		function set client(value:Object):void;
		
		function get uri():String;
	}
}