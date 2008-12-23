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

		function addChild(child : *) : *;

		function removeChild(child : *) : *;

		function addRemoteChild(child : ISynchronisedObject, isLocal : Boolean = false) : ISynchronisedObject;
	}
}
