package com.paperworld.flash.util.timer
{ 
	public interface CountdownTimerListener
	{
		/**
		 * Update the listener with the time remaining for the countdown in milliseconds.
		 */
		function updateTime(timeRemaining:Number):void;
	}
}