package com.paperworld.flash.bootstrapper
{	
	import com.paperworld.flash.core.world.World;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	public class Bootstrapper extends EventDispatcher
	{
		private static var LIB_DIR:String = "lib";
		
		public static var _instance:Bootstrapper;
		
		private var _libraries:Array = ["paperworld-util.swf","paperworld-core.swf"];
		
		private var _libraryIndex:int;
		
		private var _world:String;
		
		private var _target:Sprite;
		
		public function get target():Sprite 
		{
			return _target;
		}
		
		public function get stage():Stage
		{
			return _target.stage;
		}
		
		public function Bootstrapper(target:Sprite)
		{
			_target = target;
			
			_loadSettings();
		}

		public static function getInstance(target:Sprite = null):Bootstrapper
		{
			return _instance = (_instance == null) ? new Bootstrapper(target) : _instance;
		}
		
		public function load(world:String, libraries:Array = null):void 
		{
			if (_libraries.length > 0)
			{
				_world = world;
				_loadLibraries(libraries);
			}
			else
			{
				_loadWorld(world);
			}
		}
		
		private function _loadSettings():void 
		{
			
		}
		
		private function _loadLibraries(libraries:Array):void 
		{
			_libraries = _libraries.concat(libraries);
			
			_loadLibrary();
		}
		
		private function _loadLibrary(event:Event = null):void 
		{
			if (_libraryIndex >= _libraries.length - 1)
			{
				_loadWorld(_world);
			}
			else
			{
				var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, _loadLibrary, false, 0, true);
				
				var url:String = LIB_DIR + "/" + _libraries[_libraryIndex];
				loader.load(new URLRequest(url), new LoaderContext(false, ApplicationDomain.currentDomain));
				_libraryIndex++;
			}
		}
		
		private function _loadWorld(world:String):void 
		{
			trace("Loading World: " + world + " " + _target);
			new World(world, _target);
		}
	}
}

internal class Singleton
{
}