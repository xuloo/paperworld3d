package com.paperworld.api
{
	import com.actionengine.flash.core.interfaces.IDestroyable;
	import com.actionengine.flash.input.Input;
	import com.brainfarm.flash.data.State;		

	/**
	 * @author Trevor
	 */
	public interface ISynchronisable extends IDestroyable
	{
		function synchronise(time : int, input : Input, state : State) : void
	}
}
