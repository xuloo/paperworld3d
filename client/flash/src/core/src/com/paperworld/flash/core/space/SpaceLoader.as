package com.paperworld.flash.core.space
{
	import com.paperworld.flash.core.loading.actions.URLLoaderAction;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;

	public class SpaceLoader extends EventDispatcher
	{
		private static var logger:ILogger = LoggerFactory.getLogger("Paperworld");
		
		private var _space:Space;
		
		public function get spaceName():String 
		{
			return _space.name;
		}
		
		public function get configRequest():URLRequest 
		{
			return new URLRequest(spaceName + ".xml");
		}
		
		public function SpaceLoader(space:Space)
		{
			super(this);
			
			_space = space;
		}
		
		public function load():void 
		{
			loadConfig();
		}
		
		protected function loadConfig():void 
		{
			var configLoadAction:URLLoaderAction = new URLLoaderAction(configRequest);
			configLoadAction.addEventListener(Event.COMPLETE, onConfigLoadComplete, false, 0, true);
			configLoadAction.load();
		}
		
		protected function onConfigLoadComplete(event:Event):void 
		{			
			dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}