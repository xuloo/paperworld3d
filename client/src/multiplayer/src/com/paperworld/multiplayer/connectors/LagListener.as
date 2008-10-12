package com.paperworld.multiplayer.connectors 
{
	import com.paperworld.multiplayer.connectors.events.LagEvent;	

	/**
	 * @author Trevor
	 */
	public interface LagListener 
	{
		function onLagUpdate(event : LagEvent) : void;
	}
}
