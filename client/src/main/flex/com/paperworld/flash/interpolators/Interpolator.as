package com.paperworld.flash.interpolators 
{
	import com.paperworld.flash.data.State;				

	/**
	 * @author Trevor
	 */
	public interface Interpolator 
	{
		function interpolate(from : State, to : State, tightness : Number) : void
	}
}
