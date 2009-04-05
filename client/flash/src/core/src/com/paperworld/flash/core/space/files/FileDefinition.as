package com.paperworld.flash.core.space.files
{
	import com.paperworld.flash.core.loading.actions.AbstractLoadAction;
	
	import flash.system.ApplicationDomain;
	
	import org.as3commons.reflect.ClassUtils;
	
	public class FileDefinition
	{
		private var _type:FileType;
		
		public function get type():FileType 
		{
			return _type;
		}
				
		private var _location:String;
		
		public function get location():String 
		{
			return _location;
		}
		
		public function FileDefinition(type:String, location:String)
		{
			_type = FileType.fromName(type);
			_location = location;
		}

		public static function getFileLoader(file:FileDefinition):AbstractLoadAction
		{
			var clazz:Class = ClassUtils.forName(getLoaderClassName(file.type.name), ApplicationDomain.currentDomain);
			
			return new clazz(file);
		}
		
		private static function getLoaderClassName(type:String):String
		{
			return "com.paperworld.flash.core.loading.actions." + type + "FileLoadAction";
		}
	}
}