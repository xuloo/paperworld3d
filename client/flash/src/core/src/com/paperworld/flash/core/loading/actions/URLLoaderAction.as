package com.paperworld.flash.core.loading.actions
{
	import com.paperworld.flash.core.action.CombinationAction;
	import com.paperworld.flash.core.loading.interfaces.ILoadableAction;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class URLLoaderAction extends CombinationAction implements ILoadableAction
	{
		private var _urlRequest:URLRequest;
		
		public function get urlRequest():URLRequest
		{
			return _urlRequest;
		}
		
		private var _urlLoader:URLLoader;
		
		public function get urlLoader():URLLoader
		{
			if (!_urlLoader)
			{
				_urlLoader = new URLLoader(urlRequest);
			}
			
			return _urlLoader;
		}
		
		private var _isComplete:Boolean = false;
		
		override public function get isComplete():Boolean 
		{
			return _isComplete;
		}
		
		public function get data():*
		{
			return urlLoader.data;
		}
		
		public function get bytesLoaded():int 
		{
			var bytes:int = urlLoader.bytesLoaded;
			
			if (next)
			{
				return bytes + ILoadableAction(next).bytesLoaded;
			}
			
			return bytes;
		}
		
		public function get bytesTotal():int 
		{
			var bytes:int = urlLoader.bytesTotal;
			
			if (next)
			{
				return bytes + ILoadableAction(next).bytesTotal;
			}
			
			return bytes;
		}
		
		public function URLLoaderAction(urlRequest:URLRequest)
		{
			super();
			
			_urlRequest = urlRequest;
		}
		
		override public function act():void 
		{			
			load();
			
			super.act();
		}
		
		public function load():void 
		{
			addEventListener(Event.COMPLETE, handleCompleteEvent, false, 0, true);
			urlLoader.load(urlRequest);
		}
		
		protected function handleCompleteEvent(event:Event):void 
		{
			_isComplete = true;
		}
					
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			urlLoader.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function dispatchEvent(event:Event):Boolean
		{
			return urlLoader.dispatchEvent(event);
		}
		
		public function hasEventListener(type:String):Boolean
		{
			return urlLoader.hasEventListener(type);
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
		{
			urlLoader.removeEventListener(type, listener, useCapture);
		}
		
		public function willTrigger(type:String):Boolean
		{
			return urlLoader.willTrigger(type);
		}
	}
}