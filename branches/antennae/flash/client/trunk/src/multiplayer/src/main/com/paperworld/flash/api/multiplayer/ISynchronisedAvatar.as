package com.paperworld.flash.api.multiplayer 
{
	import com.paperworld.flash.api.IAvatar;
	import com.paperworld.flash.api.IInput;
	import com.paperworld.flash.api.IState;
	import com.paperworld.flash.util.input.IUserInput;
	
	import flash.events.Event;	

	/**
	 * @author Trevor
	 */
	public interface ISynchronisedAvatar extends IAvatar
	{
		function set userInput(value : IUserInput) : void;
		
		function set syncManager(value:ISyncManager):void;		

		function get replaying() : Boolean;

		function set replaying(replaying : Boolean) : void;

		function get tightness() : Number;

		function set tightness(tightness : Number) : void;

		function snap(state : IState) : void;

		function update(e:Event = null) : void;
		
		function destroy():void;
		
		function synchronise(time : int, input : IInput, state : IState) : void
	}
}
