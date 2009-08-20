package org.paperworld.flash.multiplayer.api 
{
	import org.paperworld.flash.api.multiplayer.ISynchronisedAvatar;
	

	/**
	 * @author Trevor
	 */
	public interface IAvatarFactory 
	{
		function getAvatar(key : String) : ISynchronisedAvatar;
	}
}
