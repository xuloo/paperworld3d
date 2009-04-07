package com.paperworld.flash.core.world
{
	import com.paperworld.flash.core.space.Space;
	import com.paperworld.flash.core.space.SpaceContext;
	
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;
	
	public class World
	{
		private static var logger:ILogger = LoggerFactory.getLogger("Paperworld(Boot)");
		
		private var _worldName:String;
		
		private var _spaces:Dictionary;
		
		public function get spaces():Dictionary
		{
			return _spaces;
		}
		
		private var _loadedSpaces:Dictionary;
		
		private var _defaultSpace:String;
		
		private var _currentSpace:Space;
		
		public function get worldName():String 
		{
			return _worldName;
		}
		
		public function World(worldName:String, autoLoad:Boolean = true)
		{
			_worldName = worldName;
			_spaces = new Dictionary(true);
			_loadedSpaces = new Dictionary(true);
			
			if (autoLoad)
			{
				load();
			}
		}
		
		public function load():void
		{
			var worldLoader:WorldLoader = new WorldLoader(this);
			worldLoader.addEventListener(Event.COMPLETE, onWorldLoadComplete, false, 0, true);
			worldLoader.load();
		}
		
		private function onWorldLoadComplete(event:Event):void 
		{
			logger.info("[" + _worldName + "] World loaded");
			
			if (_defaultSpace)
			{
				logger.info("Loading default space - [" + _defaultSpace + "]");
				loadSpace(_defaultSpace);
			}
		}	
		
		private function loadSpace(spaceName:String):void 
		{			
			var context:SpaceContext = SpaceContext(_spaces[spaceName]);
			_currentSpace = new Space(context);
			_currentSpace.addEventListener(Space.SPACE_READY, _onSpaceLoadComplete);
			_currentSpace.load();
		}
		
		private function _onSpaceLoadComplete(event:Event):void 
		{			
			var loadedSpace:Space = Space(event.target);
			
			_loadedSpaces[loadedSpace.name] = loadedSpace;
			
			logger.info("space [" + loadedSpace.name + "] is ready for use!");
		}
		
		public function registerSpaceContext(context:SpaceContext):void 
		{
			_spaces[context.name] = context;
			
			if (context.isDefault)
			{
				_defaultSpace = context.name;
			}
		}
	}
}