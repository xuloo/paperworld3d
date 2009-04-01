package com.paperworld.flash.util.timer
{ 

	public interface Timer
	{
		/**
		 * Start a timer.
		 * Provide a callback method and listener.
		 */
		function startTimer(rate:Number, listener:Object, method:Function):Number;
		
		/**
		 * Stop the timer.
		 */
		function stopTimer():void;
		
		/**
		 * Update the timer.
		 * Ensure this method is implemented by all timers.
		 * This may be an interval or the completion of the timer.
		 */
		function update():void;
		
		/**
		 * Destroy 
		 */
		function destroy():void;
	}
}