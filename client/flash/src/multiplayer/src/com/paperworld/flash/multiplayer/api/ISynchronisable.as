package com.paperworld.flash.multiplayer.api
{
	import com.paperworld.flash.multiplayer.data.State;
	import com.paperworld.flash.util.input.Input;	

	/**
	 * @author Trevor
	 */
	public interface ISynchronisable
	{
		function synchronise(time : int, input : Input, state : State) : void
	}
}
