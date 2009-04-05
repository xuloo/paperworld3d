package com.paperworld.flash.multiplayer.api 
{

	/**
	 * @author Trevor
	 */
	public interface IAvatarFactory 
	{
		function getAvatar(key : String) : ISynchronisedAvatar;
	}
}
