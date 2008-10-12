package com.paperworld.util.keys 
{
	import flash.display.InteractiveObject;
	import flash.events.KeyboardEvent;
	import flash.utils.Dictionary;
	
	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.core.BaseClass;
	import com.paperworld.core.patterns.Command;		

	/**
	 * @author Trevor
	 */
	public class KeyboardManager extends BaseClass 
	{
		public static var _instance : KeyboardManager;

		protected var _target : InteractiveObject;

		public function set target(value : InteractiveObject) : void 
		{
			_target = value;
			
			_target.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			_target.addEventListener( KeyboardEvent.KEY_UP, onKeyUp );
		}

		public var logger : XrayLog = new XrayLog( );

		public var _commands : Array;

		public function KeyboardManager()
		{
			super( );
		}

		override public function initialise() : void
		{
			_commands = new Array( );	
		}

		override public function destroy() : void
		{
			_commands = new Array( );
			_commands = null;
			
			_target.removeEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			_target.removeEventListener( KeyboardEvent.KEY_UP, onKeyUp );	
		}

		public static function getInstance() : KeyboardManager
		{
			return _instance = (_instance == null) ? new KeyboardManager( ) : _instance;
		}

		public function addCommand(key : int, type : String, command : Command) : void
		{			
			getCollection( type, getCollection( key, _commands, Array ), Dictionary )[command] = command;
		}

		public function removeCommand(key : int, type : String, command : Command) : void
		{
			var dictionary : Dictionary = Dictionary( _commands[key][type] );
			
			if (dictionary)
			{
				dictionary[command] = null;
				delete dictionary[command];
			}
		}

		protected function onKeyDown(event : KeyboardEvent) : void
		{
			for each (var command:Command in _commands[event.keyCode][KeyboardEvent.KEY_DOWN])
			{
				command.execute( );
			}
		}

		protected function onKeyUp(event : KeyboardEvent) : void
		{
			for each (var command:Command in _commands[event.keyCode][KeyboardEvent.KEY_UP])
			{
				command.execute( );
			}
		}

		protected function getCollection(key : *, collection : *, Collection : Class) : *
		{
			return collection[key] = (collection[key] == null) ? new Collection( ) : collection[key];
		}
	}
}
