package com.paperworld.core.interfaces 
{
	import com.paperworld.util.clock.events.ClockEvent;	

	/**
	 * @author Trevor
	 */
	public interface Animatable 
	{
		function play() : void;

		function pause() : void;

		function stop() : void;

		function animate(event : ClockEvent = null) : void;
	}
}
