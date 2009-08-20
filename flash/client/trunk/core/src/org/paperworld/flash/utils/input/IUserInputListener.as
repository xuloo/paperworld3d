package org.paperworld.flash.utils.input
{
	import org.paperworld.flash.utils.input.events.UserInputEvent;		

	/**
	 * @author Trevor
	 */
	public interface IUserInputListener 
	{
		function onInputUpdate(event : UserInputEvent) : void;
	}
}
