package com.paperworld.flash.core.game
{
	import com.paperworld.flash.api.IAvatar;
	
	public interface IGame
	{
		function addAvatar(avatar:IAvatar):void;
		
		function removeAvatar(avatar:IAvatar):void;
	}
}