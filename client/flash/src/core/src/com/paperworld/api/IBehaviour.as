package com.paperworld.api 
{

	/**
	 * @author Trevor
	 */
	public interface IBehaviour 
	{
		function get next() : IBehaviour;

		function set next(behaviour : IBehaviour) : void;

		function apply(avatar : ISynchronisedAvatar) : void;
	}
}
