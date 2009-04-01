package com.paperworld.flash.util.logging 
{

	/**
	 * @author Trevor
	 */
	public interface Logger 
	{
		function isEnabled() : Boolean;

		function info(msg : String, ...rest) : void;
	}
}
