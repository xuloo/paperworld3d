package com.paperworld.api 
{

	/**
	 * @author Trevor
	 */
	public interface IAvatarFactory 
	{
		function getAvatar(key : String) : ISynchronisedAvatar;
	}
}
