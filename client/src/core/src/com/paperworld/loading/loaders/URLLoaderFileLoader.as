package com.paperworld.loading.loaders 
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	import com.paperworld.core.BaseClass;
	import com.paperworld.loading.loaders.FileLoader;	

	/**
	 * @author Trevor
	 */
	public class URLLoaderFileLoader extends BaseClass implements FileLoader 
	{
		protected var _loader : URLLoader;

		public function URLLoaderFileLoader()
		{
			super( );
		}

		override public function initialise() : void
		{
			_loader = new URLLoader( );	
		}

		public function load(request : URLRequest, context : LoaderContext = null) : void
		{
			_loader.load( request );
		}

		public function getBytesLoaded() : Number
		{
			return _loader.bytesLoaded;
		}

		public function getBytesTotal() : Number
		{
			return _loader.bytesTotal;
		}

		public function getData() : *
		{
			return _loader.data;
		}

		public function dispatchEvent(event : Event) : Boolean
		{
			return _loader.dispatchEvent( event );
		}

		public function hasEventListener(type : String) : Boolean
		{
			return _loader.hasEventListener( type );
		}

		public function willTrigger(type : String) : Boolean
		{
			return _loader.willTrigger( type );
		}

		public function removeEventListener(type : String, listener : Function, useCapture : Boolean = false) : void
		{
			_loader.removeEventListener( type, listener, useCapture );
		}

		public function addEventListener(type : String, listener : Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false) : void
		{
			_loader.addEventListener( type, listener, useCapture, priority, useWeakReference );
		}
	}
}
