package com.paperworld.flash.multiplayer.api 
{
	import com.paperworld.flash.api.multiplayer.ISynchronisedAvatar;
	

	/**
	 * @author Trevor
	 */
	public interface IAvatarFactory 
	{
		function getAvatar(key : String) : ISynchronisedAvatar;
	}
}
