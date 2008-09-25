package com.paperworld.bootstrapper 
{
	import flash.display.Sprite;
	import flash.events.Event;

	import org.pranaframework.context.support.XMLApplicationContext;	

	/**
	 * @author Trevor
	 */
	public class Bootstrapper extends Sprite
	{
		private static const MAIN_CLASS_KEY : String = "main.class";
		
		private static var _instance : Bootstrapper;

		public var applicationContext : XMLApplicationContext;

		public function Bootstrapper()
		{
			initialise( );
		}
		
		public static function getInstance():Bootstrapper
		{
			return _instance;
		}

		private function initialise() : void
		{
			_instance = this;
			
			applicationContext = new XMLApplicationContext( "rootContext.xml" );
			applicationContext.addEventListener( Event.COMPLETE, onContextLoaded );
			applicationContext.load( );	
		}

		private function onContextLoaded(event : Event) : void
		{
			applicationContext.getObject( MAIN_CLASS_KEY, [ loaderInfo.parameters ] );
		}
	}
}