package com.paperworld.flash.core.input 
{
	import com.paperworld.flash.core.input.events.UserInputEvent;		

	/**
	 * @author Trevor
	 */
	public interface IUserInputListener 
	{
		function onInputUpdate(event : UserInputEvent) : void;
	}
}
