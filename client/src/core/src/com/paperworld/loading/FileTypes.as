package com.paperworld.loading 
{
	import com.paperworld.loading.loaders.FileLoader;
	import com.paperworld.loading.loaders.LoaderFileLoader;
	import com.paperworld.loading.loaders.URLLoaderFileLoader;
	
	import de.polygonal.ds.HashMap;		

	/**
	 * @author Trevor
	 */
	public class FileTypes 
	{
		private static var LOADER_CLASS : Class = LoaderFileLoader;

		private static var URLLOADER_CLASS : Class = URLLoaderFileLoader;

		public static var LOADER_TYPES : HashMap = createFileTypes( );

		public static const PAPERWORLD_LANGUAGE_DEFINITION : String = "pld";

		public static const LIBRARY : String = "library";

		public static const SKIN : String = "skin";

		private static function createFileTypes() : HashMap
		{
			var fileTypes : HashMap = new HashMap( );
			
			fileTypes.insert( PAPERWORLD_LANGUAGE_DEFINITION, new Array( URLLoaderFileLoader ) );
			fileTypes.insert( LIBRARY, new Array( LoaderFileLoader ) );
			fileTypes.insert( SKIN, new Array( LoaderFileLoader ) );
			
			return fileTypes;
		}

		public static function getLoader(type : String) : FileLoader
		{
			var LoaderClass : Class = LOADER_TYPES.find( type )[0] as Class;
			
			return new LoaderClass( );	
		}
	}
}
