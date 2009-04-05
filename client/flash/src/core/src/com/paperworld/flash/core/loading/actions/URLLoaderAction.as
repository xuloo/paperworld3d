package com.paperworld.flash.core.loading.actions
{
	import com.paperworld.flash.core.loading.interfaces.ILoadableAction;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class URLLoaderAction extends AbstractLoadAction implements ILoadableAction
	{		
		private var _urlLoader:URLLoader;
		
		public function get urlLoader():URLLoader
		{
			if (!_urlLoader)
			{
				_urlLoader = new URLLoader(urlRequest);
				addEventListener(Event.COMPLETE, handleCompleteEvent, false, 0, true);
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
		
		override public function act():void 
		{			
			load();
			
			super.act();
		}
		
		override public function load():void 
		{
			urlLoader.load(urlRequest);
		}
					
		override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			urlLoader.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		override public function dispatchEvent(event:Event):Boolean
		{
			return urlLoader.dispatchEvent(event);
		}
		
		override public function hasEventListener(type:String):Boolean
		{
			return urlLoader.hasEventListener(type);
		}
		
		override public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
		{
			urlLoader.removeEventListener(type, listener, useCapture);
		}
		
		override public function willTrigger(type:String):Boolean
		{
			return urlLoader.willTrigger(type);
		}
	}
}