package com.paperworld.flash.core.loading.actions
{
	import com.paperworld.flash.core.loading.interfaces.ILoadableAction;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;

	public class URLLoaderAction extends AbstractLoadAction implements ILoadableAction
	{		
		private static var logger:ILogger = LoggerFactory.getLogger("Paperworld(Core)");
		
		private var _urlLoader:URLLoader;
		
		public function get urlLoader():URLLoader
		{
			if (!_urlLoader)
			{
				_urlLoader = new URLLoader(urlRequest);
				_urlLoader.addEventListener(Event.COMPLETE, handleCompleteEvent, false, 0, true);
				_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, handleIOError, false, 0, true);
			}
			
			return _urlLoader;
		}
		
		private var _isComplete:Boolean = false;
		
		override public function get isComplete():Boolean 
		{
			return _isComplete;
		}
		
		override public function get data():*
		{
			return urlLoader.data;
		}
		
		override public function get bytesLoaded():int 
		{
			var bytes:int = urlLoader.bytesLoaded;
			
			if (next)
			{
				return bytes + AbstractLoadAction(next).bytesLoaded;
			}
			
			return bytes;
		}
		
		override public function get bytesTotal():int 
		{
			var bytes:int = urlLoader.bytesTotal;
			
			if (next)
			{
				return bytes + AbstractLoadAction(next).bytesTotal;
			}
			
			return bytes;
		}
		
		public function URLLoaderAction(urlRequest:URLRequest)
		{
			super(urlRequest);
		}
				
		override protected function load():void 
		{
			logger.info("loading: " + urlRequest.url);
			urlLoader.load(urlRequest);
		}
	}
}