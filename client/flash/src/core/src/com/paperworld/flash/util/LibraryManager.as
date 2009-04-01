package com.paperworld.flash.util
{

	/**
	 * @author Trevor
	 */
	public class LibraryManager
	{
		private static var $instance : LibraryManager;

		private var $cache : Object;

		public function LibraryManager(singleton : Singleton)
		{
			super( );
		}
		
		public function initialise():void 
		{
			$cache = new Object();
			
			
		}

		public static function getInstance() : LibraryManager
		{
			return ($instance == null) ? new LibraryManager( new Singleton( ) ) : $instance;
		}
	}
}

internal class Singleton
{
}
