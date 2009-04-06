package com.paperworld.flash.core.loading.actions
{
	import com.paperworld.flash.core.action.CombinationAction;
	import com.paperworld.flash.core.loading.interfaces.ILoadCompleteHandler;
	import com.paperworld.flash.core.loading.interfaces.ILoadableAction;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;

	public class AbstractLoadAction extends CombinationAction implements ILoadableAction
	{
		private static var logger:ILogger = LoggerFactory.getLogger("Paperworld(Core)");
		
		private var _urlRequest:URLRequest;
		
		public function get urlRequest():URLRequest
		{
			return _urlRequest;
		}
				
		private var _isComplete:Boolean = false;
		
		override public function get isComplete():Boolean 
		{
			return !_isComplete ? false : super.isComplete;
		}
		
		public function get data():*
		{
			return null;
		}
		
		public function get bytesLoaded():int 
		{			
			return 0;
		}
		
		public function get bytesTotal():int 
		{
			return 0;
		}
		
		protected var loadCompleteHandler:ILoadCompleteHandler;
		
		public function AbstractLoadAction(urlRequest:URLRequest = null)
		{
			super();
			
			_urlRequest = urlRequest;
		}
		
		override public function act():void 
		{			
			load();
			
			super.act();
		}
		
		protected function load():void
		{
		}
		
		protected function handleCompleteEvent(event:Event):void 
		{
			logger.info("handleCompleteEvent()");
			
			_isComplete = true;
			
			if (loadCompleteHandler)
			{
				loadCompleteHandler.handleLoadComplete(data);
			}
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		protected function handleIOError(event:IOErrorEvent):void 
		{
			throw new Error("IOError while trying to load " + urlRequest.url);
		}		
	}
}