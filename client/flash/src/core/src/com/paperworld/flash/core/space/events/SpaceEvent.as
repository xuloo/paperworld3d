package com.paperworld.flash.core.space.events
{
	import com.paperworld.flash.core.space.Space;
	
	import flash.events.Event;

	public class SpaceEvent extends Event
	{
		public static const SPACE_READY:String = "SpaceReady";
		public static const SPACE_STARTED:String = "SpaceStarted";
		public static const SPACE_STOPPED:String = "SpaceStopped";
		
		public var space:Space;
		
		public function SpaceEvent(type:String, space:Space, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			this.space = space;
		}
		
	}
}