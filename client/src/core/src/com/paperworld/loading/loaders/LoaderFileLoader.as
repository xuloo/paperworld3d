package com.paperworld.loading.loaders 
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	import com.paperworld.core.BaseClass;
	import com.paperworld.loading.loaders.FileLoader;	

	/**
	 * @author Trevor
	 */
	public class LoaderFileLoader extends BaseClass implements FileLoader 
	{
		protected var _loader : Loader;

		public function LoaderFileLoader()
		{
			super( );
		}

		override public function initialise() : void
		{
			_loader = new Loader( );	
		}

		public function load(request : URLRequest, context : LoaderContext = null) : void
		{
			_loader.load( request, context );
		}

		public function getBytesLoaded() : Number
		{
			return _loader.contentLoaderInfo.bytesLoaded;
		}

		public function getBytesTotal() : Number
		{
			return _loader.contentLoaderInfo.bytesTotal;
		}

		public function getData() : *
		{
			return _loader.contentLoaderInfo.content;
		}

		public function dispatchEvent(event : Event) : Boolean
		{
			return _loader.contentLoaderInfo.dispatchEvent( event );
		}

		public function hasEventListener(type : String) : Boolean
		{
			return _loader.contentLoaderInfo.hasEventListener( type );
		}

		public function willTrigger(type : String) : Boolean
		{
			return _loader.contentLoaderInfo.willTrigger( type );
		}

		public function removeEventListener(type : String, listener : Function, useCapture : Boolean = false) : void
		{
			_loader.contentLoaderInfo.removeEventListener( type, listener, useCapture );
		}

		public function addEventListener(type : String, listener : Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false) : void
		{
			_loader.contentLoaderInfo.addEventListener( type, listener, useCapture, priority, useWeakReference );
		}
	}
}
