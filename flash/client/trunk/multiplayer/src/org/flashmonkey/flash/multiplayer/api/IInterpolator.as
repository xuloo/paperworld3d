package org.paperworld.flash.multiplayer.api
{
	import org.paperworld.flash.api.IState;					
	
	/**
	 * @author Trevor
	 */
	public interface IInterpolator 
	{
		function interpolate(from : IState, to : IState, tightness : Number) : void
	}
}
