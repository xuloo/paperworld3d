package com.paperworld.flash.core.space.interfaces
{
	import com.paperworld.flash.core.space.events.SpaceEvent;
	
	public interface ISpaceListener
	{
		function onSpaceStarted(event:SpaceEvent):void;
		
		function onSpaceStopped(event:SpaceEvent):void;
	}
}