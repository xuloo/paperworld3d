package com.paperworld.flash.core.space
{
	import com.paperworld.flash.core.space.files.FileDefinition;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class Space extends EventDispatcher
	{
		public static const SPACE_READY:String = "SpaceReady";
		
		private var _context:SpaceContext;
		
		public function get name():String 
		{
			return _context.name;
		}
		
		public function Space(context:SpaceContext)
		{
			super(this);
			
			_context = context;
		}
		
		public function load():void 
		{
			var spaceLoader:SpaceLoader = new SpaceLoader(_context);
			spaceLoader.addEventListener(Event.COMPLETE, _onSpaceLoadComplete);
			spaceLoader.load();
		}	
		
		private function _onSpaceLoadComplete(event:Event):void 
		{
			SpaceLoader(event.target).removeEventListener(Event.COMPLETE, _onSpaceLoadComplete);

			dispatchEvent(new Event(SPACE_READY));
		}
	}
}