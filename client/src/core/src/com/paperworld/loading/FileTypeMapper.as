package com.paperworld.loading 
{
	import com.paperworld.util.string.StringUtils;	

	import flash.utils.Dictionary;

	import com.paperworld.loading.loaders.FileLoader;		

	/**
	 * @author Trevor
	 */
	public class FileTypeMapper 
	{
		public var map : Dictionary;

		public function getLoader(url : String) : FileLoader
		{
			return FileLoader( map[StringUtils.getFileEnding( url )] );
		}
	}
}
