package com.paperworld.flash.core.game
{
	import com.paperworld.flash.api.multiplayer.ISynchronisedAvatar;
	
	public interface IGame
	{
		function addAvatar(avatar:ISynchronisedAvatar):void;
		
		function removeAvatar(avatar:ISynchronisedAvatar):void;
	}
}