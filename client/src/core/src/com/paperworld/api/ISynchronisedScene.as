package com.paperworld.api 
{
	import com.paperworld.flash.connectors.IConnector;	
	import com.paperworld.flash.player.Player;		

	/**
	 * @author Trevor
	 */
	public interface ISynchronisedScene
	{
		function connect(...args) : void

		function set connector(value : IConnector) : void;

		function get connector() : IConnector;

		function addPlayer(player : Player, isLocal : Boolean = true) : void;

		function get scene() : *;

		function set scene(value : *) : void;

		function addChild(child : *, name : String) : *;

		function removeChild(child : *) : *;

		function addRemoteChild(child : ISynchronisedObject, name : String, isLocal : Boolean = false) : ISynchronisedObject;

		function set avatarFactory(factory : IAvatarFactory) : void;
	}
}
