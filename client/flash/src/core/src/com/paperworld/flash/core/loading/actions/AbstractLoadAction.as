package com.paperworld.flash.core.loading.actions
{
	import com.paperworld.flash.core.action.CombinationAction;
	import com.paperworld.flash.core.loading.interfaces.ILoadableAction;
	
	import flash.events.Event;
	import flash.net.URLRequest;

	public class AbstractLoadAction extends CombinationAction implements ILoadableAction
	{
		private var _urlRequest:URLRequest;
		
		public function get urlRequest():URLRequest
		{
			return _urlRequest;
		}
				
		private var _isComplete:Boolean = false;
		
		override public function get isComplete():Boolean 
		{
			return _isComplete;
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
		
		public function AbstractLoadAction(urlRequest:URLRequest)
		{
			super();
			
			_urlRequest = urlRequest;
		}
		
		public function load():void
		{
		}
		
		protected function handleCompleteEvent(event:Event):void 
		{
			_isComplete = true;
			
			onLoadComplete();
		}
		
		protected function onLoadComplete():void 
		{
			
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
		}
		
		public function dispatchEvent(event:Event):Boolean
		{
			return false;
		}
		
		public function hasEventListener(type:String):Boolean
		{
			return false;
		}
		
		public function willTrigger(type:String):Boolean
		{
			return false;
		}
		
	}
}