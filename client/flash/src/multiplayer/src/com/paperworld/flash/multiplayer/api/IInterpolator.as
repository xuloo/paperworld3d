package com.paperworld.flash.multiplayer.api
{
	import com.paperworld.flash.core.objects.State;					
	
	/**
	 * @author Trevor
	 */
	public interface IInterpolator 
	{
		function interpolate(from : State, to : State, tightness : Number) : void
	}
}
