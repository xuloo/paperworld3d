package com.paperworld.flash.core.objects
{
	import com.paperworld.flash.core.action.Action;
	
	public interface IPaperworldObject
	{
		function get behaviour():Action
		function set behaviour(value:Action):void;
		
		function get displayObject():*;
		function set displayObject(value:*):void;
	}
}