package com.paperworld.api 
{
	import com.actionengine.flash.input.Input;
	import com.paperworld.flash.data.State;		

	/**
	 * @author Trevor
	 */
	public interface ISynchronisedAvatar extends ISynchronisable
	{
		function getNext() : ISynchronisedAvatar;

		function setNext(value : ISynchronisedAvatar) : void;

		function getSynchronisedObject() : ISynchronisedObject;

		function setSynchronisedObject(value : ISynchronisedObject) : void;

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
	}
}
