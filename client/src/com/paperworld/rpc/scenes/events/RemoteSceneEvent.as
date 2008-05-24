package com.paperworld.rpc.scenes.events
{
	import flash.events.Event;

	public class RemoteSceneEvent extends Event
	{
		public static const ADD_PLAYER_SUCCESS:String = "AddPlayerSuccess";
		public static const ADD_PLAYER_FAIL:String = "AddPlayerFail";
		
		public function RemoteSceneEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}