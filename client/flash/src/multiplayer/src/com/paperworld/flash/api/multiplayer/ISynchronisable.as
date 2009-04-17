package com.paperworld.flash.api.multiplayer
{
	import com.paperworld.flash.multiplayer.data.State;
	import com.paperworld.flash.util.input.IInput;	

	/**
	 * @author Trevor
	 */
	public interface ISynchronisable
	{
		function synchronise(time : int, input : IInput, state : State) : void
	}
}
