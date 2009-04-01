package com.paperworld.api
{
	import com.paperworld.flash.data.State;
	import com.paperworld.flash.input.Input;	

	/**
	 * @author Trevor
	 */
	public interface ISynchronisable
	{
		function synchronise(time : int, input : Input, state : State) : void
	}
}
