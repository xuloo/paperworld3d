package org.paperworld.flash.utils.clock 
{
	import org.paperworld.flash.utils.clock.events.ClockEvent;	

	/**
	 * @author Trevor
	 */
	public interface IClockListener 
	{
		function onTick(event : ClockEvent) : void;
	}
}
