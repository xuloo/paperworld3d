package org.paperworld.flash.core.game
{
	import org.paperworld.flash.api.IAvatar;
	
	public interface IGame
	{
		function addAvatar(avatar:IAvatar):void;
		
		function removeAvatar(avatar:IAvatar):void;
	}
}