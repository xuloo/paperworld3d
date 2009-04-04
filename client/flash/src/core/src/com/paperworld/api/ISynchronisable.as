package com.paperworld.api
{
	import com.paperworld.flash.input.Input;
	import com.paperworld.flash.multiplayer.data.State;	

	/**
	 * @author Trevor
	 */
	public interface ISynchronisable
	{
		function synchronise(time : int, input : Input, state : State) : void
	}
}
