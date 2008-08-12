package com.paperworld.util
{
	import com.paperworld.core.Destroyable;
	import com.paperworld.data.State;	

	/**
	 * @author Trevor
	 */
	public interface Synchronizable extends Destroyable
	{
		function synchronise(state : State) : void
	}
}
