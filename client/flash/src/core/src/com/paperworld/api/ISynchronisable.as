package com.paperworld.api
{
	import com.actionengine.flash.api.IInput;
	import com.actionengine.flash.core.interfaces.IDestroyable;
	import com.brainfarm.flash.data.State;	

	/**
	 * @author Trevor
	 */
	public interface ISynchronisable extends IDestroyable
	{
		function synchronise(time : int, input : IInput, state : State) : void
	}
}
