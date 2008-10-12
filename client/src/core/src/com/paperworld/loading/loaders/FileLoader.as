package com.paperworld.loading.loaders 
{
	import flash.events.IEventDispatcher;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;		

	/**
	 * @author Trevor
	 */
	public interface FileLoader extends IEventDispatcher
	{		
		function load(request : URLRequest, context : LoaderContext = null) : void;

		function getBytesLoaded() : Number;

		function getBytesTotal() : Number;

		function getData() : *;
	}
}
