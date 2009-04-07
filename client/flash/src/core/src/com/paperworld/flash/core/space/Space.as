package com.paperworld.flash.core.space
{
	import com.paperworld.flash.core.objects.IPaperworldObject;
	import com.paperworld.flash.core.space.events.SpaceEvent;
	import com.paperworld.flash.core.space.interfaces.ISpaceListener;
	import com.paperworld.flash.core.space.interfaces.ISpaceView;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;

	public class Space extends EventDispatcher
	{		
		private static var logger:ILogger = LoggerFactory.getLogger("Paperworld(Core)");
		
		private var _timer:Timer;
		
		private var _context:SpaceContext;
		
		public function get name():String 
		{
			return _context.name;
		}
		
		public function Space(context:SpaceContext)
		{
			super(this);
			
			_context = context;
			_timer = new Timer(200, 0);
			_timer.addEventListener(TimerEvent.TIMER, _onTimer);
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

			_registerViews();

			dispatchEvent(new SpaceEvent(SpaceEvent.SPACE_READY, this));
		}
		
		private function _registerViews():void 
		{
			for each (var view:ISpaceView in _context.views)
			{
				addListener(view);
				view.target = _context.target;
			}
		}
		
		public function start():void 
		{
			logger.info("Starting space");
			_timer.start();
			dispatchEvent(new SpaceEvent(SpaceEvent.SPACE_STARTED, this));
		}
		
		public function stop():void 
		{
			dispatchEvent(new SpaceEvent(SpaceEvent.SPACE_STOPPED, this));
		}
		
		private function _onTimer(event:TimerEvent):void 
		{
			for each (var actor:IPaperworldObject in _context.actors)
			{
				actor.behaviour.act();
			}
		}
		
		public function addListener(listener:ISpaceListener):void 
		{
			addEventListener(SpaceEvent.SPACE_STARTED, listener.onSpaceStarted, false, 0, true);
			addEventListener(SpaceEvent.SPACE_STOPPED, listener.onSpaceStopped, false, 0, true);
		}
		
		public function removeListener(listener:ISpaceListener):void 
		{
			removeEventListener(SpaceEvent.SPACE_STARTED, listener.onSpaceStarted, false);
			removeEventListener(SpaceEvent.SPACE_STOPPED, listener.onSpaceStopped, false);
		}
	}
}