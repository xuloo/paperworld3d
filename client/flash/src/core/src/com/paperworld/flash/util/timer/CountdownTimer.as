package com.paperworld.flash.util.timer 
{ 

	public class CountdownTimer extends AccurateTimer
	{
		/**
		 * Constructor.
		 */
		public function CountdownTimer()
		{
			super();
		}
	
		/**
		 * Update the timer with the number of milliseconds remaining.
		 * Pass the re-syncronished countdown time to listener.
		 */
		public function synchroniseTimer(milliseconds:Number):void
		{
			setEndTime(milliseconds);
			update();
		}
	
		/**
		 * Self update - allows clock resyncronisation.
		 * Inform listener of time remaining.
		 * Forward to parent class to check against endtime.
		 */
		override public function update():void
		{
			CountdownTimerListener(listener).updateTime(getTimeRemaining());
			super.update();
		}
	}
}