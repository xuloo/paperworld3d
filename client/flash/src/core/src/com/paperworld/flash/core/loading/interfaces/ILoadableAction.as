package com.paperworld.flash.core.loading.interfaces
{
	import flash.events.IEventDispatcher;
	
	public interface ILoadableAction extends IEventDispatcher
	{
		function load():void;
		
		function get bytesLoaded():int;
		
		function get bytesTotal():int;
		
		function get data():*;
	}
}