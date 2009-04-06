package com.paperworld.flash.core.world
{
	import com.paperworld.flash.core.action.Action;
	import com.paperworld.flash.core.loading.actions.URLLoaderAction;
	import com.paperworld.flash.core.loading.interfaces.ILoadableAction;
	import com.paperworld.flash.core.world.parsers.WorldDefinitionParser;
	import com.paperworld.flash.util.xml.IXMLDefinitionsParser;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;
	
	public class WorldLoader extends EventDispatcher
	{
		private static var logger:ILogger = LoggerFactory.getLogger("Paperworld(Boot)");
		
		protected var parser:IXMLDefinitionsParser;
		
		private var _world:World; 
		
		public function get worldName():String 
		{
			return _world.worldName;
		}
		
		public function get configRequest():URLRequest
		{
			return new URLRequest(worldName + ".xml");
		}
		
		private var _worldConfigLoader:Action;
		
		public function WorldLoader(world:World)
		{
			super(this);
			
			_world = world;
			
			initialise();
		}
		
		protected function initialise():void 
		{
			parser = new WorldDefinitionParser(_world);
		}
		
		public function load():void 
		{			
			_worldConfigLoader = new URLLoaderAction(configRequest);
			_worldConfigLoader.addEventListener(Event.COMPLETE, _onWorldConfigLoadComplete, false, 0, true);
			_worldConfigLoader.act();
		}
		
		private function _onWorldConfigLoadComplete(event:Event):void 
		{			
			var worldXML:XML = new XML(ILoadableAction(_worldConfigLoader).data);
					
			parser.parse(worldXML);

			dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}