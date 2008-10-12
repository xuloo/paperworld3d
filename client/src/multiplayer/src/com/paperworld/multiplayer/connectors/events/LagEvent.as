package com.paperworld.multiplayer.connectors.events 
{
	import flash.events.Event;

	/**
	 * @author Trevor
	 */
	public class LagEvent extends Event 
	{
		public static var LAG_UPDATE : String = "LagUpdate";

		public var serverTime:int;

		public var lag : int;

		public function LagEvent(serverTime:int, lag : int, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super( LAG_UPDATE, bubbles, cancelable );
			
			this.serverTime = serverTime;
			this.lag = lag;
		}
	}
}
