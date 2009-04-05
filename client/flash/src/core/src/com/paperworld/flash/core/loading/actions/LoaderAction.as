package com.paperworld.flash.core.loading.actions
{
	import com.paperworld.flash.core.loading.interfaces.ILoadableAction;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;

	public class LoaderAction extends AbstractLoadAction implements ILoadableAction
	{		
		private static var logger:ILogger = LoggerFactory.getLogger("Paperworld(Boot)");
		
		private var _loader:Loader;
		
		public function get loader():*
		{
			if (!_loader)
			{
				_loader = new Loader();
				addEventListener(Event.COMPLETE, handleCompleteEvent, false, 0, true);
			}
			
			return _loader;
		}
		
		override public function get data():*
		{
			return loader.contentLoaderInfo.content;
		}
		
		override public function get bytesLoaded():int 
		{
			var bytes:int = loader.contentLoaderInfo.bytesLoaded;
			
			if (next)
			{
				return bytes + AbstractLoadAction(next).bytesLoaded;
			}
			
			return bytes;
		}
		
		override public function get bytesTotal():int 
		{
			var bytes:int = loader.contentLoaderInfo.bytesTotal;
			
			if (next)
			{
				return bytes + AbstractLoadAction(next).bytesTotal;
			}
			
			return bytes;
		}
		
		public function LoaderAction(urlRequest:URLRequest)
		{
			super(urlRequest);
		}
		
		override public function load():void 
		{
			logger.info("loading " + urlRequest.url);
			loader.load(urlRequest);
		}
		
		override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			loader.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		override public function dispatchEvent(event:Event):Boolean
		{
			return loader.dispatchEvent(event);
		}
		
		override public function hasEventListener(type:String):Boolean
		{
			return loader.hasEventListener(type);
		}
		
		override public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
		{
			loader.removeEventListener(type, listener, useCapture);
		}
		
		override public function willTrigger(type:String):Boolean
		{
			return loader.willTrigger(type);
		}
	}
}