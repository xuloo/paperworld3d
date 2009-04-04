package com.paperworld.api 
{
	import com.paperworld.flash.core.input.IUserInput;
	import com.paperworld.flash.core.input.Input;
	import com.paperworld.flash.multiplayer.data.State;	

	/**
	 * @author Trevor
	 */
	public interface ISynchronisedAvatar extends ISynchronisable
	{
		function set userInput(value : IUserInput) : void

		function getNext() : ISynchronisedAvatar;

		function setNext(value : ISynchronisedAvatar) : void;

		function getSynchronisedObject() : ISynchronisedObject;

		function setSynchronisedObject(value : ISynchronisedObject) : void;

		function getRef() : String;

		function setRef(ref : String) : void;

		function getTime() : int;

		function setTime(time : int) : void;

		function getInput() : Input;

		function setInput(input : Input) : void;

		function getState() : State;

		function setState(state : State) : void;

		function getReplaying() : Boolean;

		function setReplaying(replaying : Boolean) : void;

		function getTightness() : Number;

		function setTightness(tightness : Number) : void;

		function snap(state : State) : void;

		function update() : void;
		
		function destroy():void;
	}
}
