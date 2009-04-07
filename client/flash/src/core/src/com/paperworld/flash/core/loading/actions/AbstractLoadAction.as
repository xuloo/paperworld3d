package com.paperworld.flash.core.loading.actions
{
	import com.paperworld.flash.core.action.CombinationAction;
	import com.paperworld.flash.core.loading.interfaces.ILoadCompleteHandler;
	import com.paperworld.flash.core.loading.interfaces.ILoadableAction;
	
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
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
		
		protected var loading:Boolean;
				
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
		
		private var _depends:Array;
		
		public function AbstractLoadAction(urlRequest:URLRequest = null, depends:Array = null)
		{
			super();
			
			_urlRequest = urlRequest;
			_depends = depends;
		}
		
		override public function act():void 
		{		
			if (!loading)
			{
				loading = true;
				load();
			}
			
			super.act();
		}
		
		protected function load():void 
		{
		
		}
		
		protected function configureListeners(dispatcher:IEventDispatcher):void {
            dispatcher.addEventListener(Event.COMPLETE, completeHandler);
            dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
            dispatcher.addEventListener(Event.INIT, initHandler);
            dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            dispatcher.addEventListener(Event.OPEN, openHandler);
            dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
        }

        protected function completeHandler(event:Event):void {
            logger.info("completeHandler: " + event);
            
            _isComplete = true;
			
			if (loadCompleteHandler)
			{
				loadCompleteHandler.handleLoadComplete(data);
			}
			
			logger.info("dispatching Event.COMPLETE");
			dispatchEvent(new Event(Event.COMPLETE));
        }

        protected function httpStatusHandler(event:HTTPStatusEvent):void {
            logger.info("httpStatusHandler: " + event);
        }

        protected function initHandler(event:Event):void {
            logger.info("initHandler: " + event);
        }

        protected function ioErrorHandler(event:IOErrorEvent):void {
            logger.info("ioErrorHandler: " + event);
        }

        protected function openHandler(event:Event):void {
            logger.info("openHandler: " + event);
        }

        protected function progressHandler(event:ProgressEvent):void {
            logger.info("progressHandler: bytesLoaded=" + event.bytesLoaded + " bytesTotal=" + event.bytesTotal);
        }		
	}
}