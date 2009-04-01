package com.paperworld.flash.util.clock 
{
	import com.paperworld.flash.util.clock.events.ClockEvent;	

	/**
	 * @author Trevor
	 */
	public interface IClockListener 
	{
		function onTick(event : ClockEvent) : void;
	}
}
