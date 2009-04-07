package com.paperworld.flash.core.space.interfaces
{
	import flash.display.Sprite;
	
	public interface ISpaceView extends ISpaceListener
	{
		function get name():String;
		
		function set target(value:Sprite):void;
	}
}