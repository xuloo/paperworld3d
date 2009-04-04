package com.paperworld.flash.util
{
	import flash.utils.Dictionary;
	

	/**
	 * @author Trevor
	 */
	public class LibraryManager
	{
		private static var _instance : LibraryManager;

		private var _cache : Object;
		
		private var _assets:Dictionary;
  
		public function LibraryManager(singleton : Singleton)
		{
			super( );
		}
		
		public function initialise():void 
		{
			_assets = new Dictionary(true);
			_cache = new Object();
		}

		public static function getInstance() : LibraryManager
		{
			return (_instance == null) ? new LibraryManager( new Singleton( ) ) : _instance;
		}
	}
}

internal class Singleton
{
}
