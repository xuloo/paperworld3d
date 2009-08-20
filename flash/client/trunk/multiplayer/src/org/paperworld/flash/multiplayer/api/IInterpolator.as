package org.paperworld.flash.multiplayer.api
{
	import org.paperworld.flash.core.objects.State;					
	
	/**
	 * @author Trevor
	 */
	public interface IInterpolator 
	{
		function interpolate(from : State, to : State, tightness : Number) : void
	}
}
