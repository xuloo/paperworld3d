package com.paperworld.api 
{
	import com.actionengine.flash.api.IInput;
	import com.actionengine.flash.input.IUserInput;
	import com.brainfarm.flash.data.State;	

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

		function getInput() : IInput;

		function setInput(input : IInput) : void;

		function getState() : State;

		function setState(state : State) : void;

		function getReplaying() : Boolean;

		function setReplaying(replaying : Boolean) : void;

		function getTightness() : Number;

		function setTightness(tightness : Number) : void;

		function snap(state : State) : void;

		function update() : void;
	}
}
