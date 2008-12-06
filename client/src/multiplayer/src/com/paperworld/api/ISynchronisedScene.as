package com.paperworld.api 
{
	import com.paperworld.multiplayer.player.Player;	

	/**
	 * @author Trevor
	 */
	public interface ISynchronisedScene
	{
		function addPlayer(player : Player, isLocal : Boolean = true) : void;
	}
}
