package com.paperworld.flash.input 
{
	import com.paperworld.flash.input.events.UserInputEvent;		

	/**
	 * @author Trevor
	 */
	public interface IUserInputListener 
	{
		function onInputUpdate(event : UserInputEvent) : void;
	}
}
