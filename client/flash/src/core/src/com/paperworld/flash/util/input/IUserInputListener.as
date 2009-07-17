package com.paperworld.flash.util.input
{
	import com.paperworld.flash.util.input.events.UserInputEvent;		

	/**
	 * @author Trevor
	 */
	public interface IUserInputListener 
	{
		function onInputUpdate(event : UserInputEvent) : void;
	}
}
