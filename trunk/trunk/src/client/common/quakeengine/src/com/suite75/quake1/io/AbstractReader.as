package com.suite75.quake1.io
{
	import com.paperworld.logging.LoggerFactory;	
	import com.paperworld.logging.ILogger;	
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	public class AbstractReader extends EventDispatcher
	{
		public var filename:String;
		
		public var dataFormat:String;
		
		public var logger : ILogger;

		/**
		 * Constructor.
		 * 
		 * @param 	dataFormat
		 */ 
		public function AbstractReader(dataFormat:String=null)
		{
			logger = LoggerFactory.getLogger(this);
			
			this.dataFormat = dataFormat || URLLoaderDataFormat.BINARY;
		}

		/**
		 * Load.
		 * 
		 * @param	asset An url or a ByteArray
		 */ 
		public function load(asset:*):void
		{
			this.filename = "unknown.file";
			
			if(asset is ByteArray)
			{
				parse(asset as ByteArray);
			}
			else if(asset is String)
			{
				this.filename = String(asset);
				var loader:URLLoader = new URLLoader();
				loader.dataFormat = this.dataFormat;
				loader.addEventListener(Event.COMPLETE, onLoadComplete);
				loader.addEventListener( IOErrorEvent.IO_ERROR, onLoadError);
				loader.addEventListener( ProgressEvent.PROGRESS, onLoadProgress);
				loader.load(new URLRequest(this.filename));
			}
			else
				throw new Error("Need a url or a ByteArray!");
		}
		
		/**
		 * Parse!
		 * 
		 * @param 	data
		 */ 
		protected function parse(data:ByteArray):void
		{
		}
		
		/**
		 * 
		 * @param	event
		 */ 
		protected function onLoadComplete(event:Event):void
		{
			var loader:URLLoader = event.target as URLLoader;
			logger.info("MDL Load Complete");
			parse(loader.data);
		}
		
		/**
		 * 
		 * @param	event
		 */ 
		protected function onLoadError(event:IOErrorEvent):void
		{
			
		}
		
		/**
		 * 
		 * @param	event
		 */ 
		protected function onLoadProgress(event:ProgressEvent):void
		{
			
		}
	}
}