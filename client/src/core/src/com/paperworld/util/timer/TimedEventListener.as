package com.paperworld.util.timer
{ 
	public interface TimedEventListener 
	{
		/**
		 * Pass the stored object back to the listener after the time has expired.
		 */
		function notify(event:Object):void;
	}
}