package com.paperworld.api 
{
	import com.paperworld.flash.input.IUserInput;
	import com.paperworld.flash.player.Player;
	
	import flash.events.IEventDispatcher;			

	/**
	 * @author Trevor
	 */
	public interface ISynchronisedScene extends IEventDispatcher
	{
		function connect(...args) : void

		function addPlayer(player : Player, isLocal : Boolean = true) : void;

		function get scene() : *;

		function set scene(value : *) : void;

		function set userInput(userInput : IUserInput) : void;

		function addChild(child : *, name : String) : *;

		function removeChild(child : *) : *;

		function addRemoteChild(child : ISynchronisedObject, name : String, isLocal : Boolean = false) : ISynchronisedObject;

		function set avatarFactory(factory : IAvatarFactory) : void;
	}
}
