package com.paperworld.input 
{
	import com.paperworld.input.events.UserInputEvent;	
	
	/**
	 * @author Trevor
	 */
	public interface UserInputListener 
	{
		function onInputUpdate(event : UserInputEvent) : void;
	}
}
