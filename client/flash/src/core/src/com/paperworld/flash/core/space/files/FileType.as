package com.paperworld.flash.core.space.files
{
	import org.springextensions.actionscript.utils.Assert;
	import org.springextensions.actionscript.utils.StringUtils;
	
	public class FileType
	{
		/** Skin File */
		public static const FILETYPE_SKIN:FileType = new FileType(FILETYPE_SKIN_NAME);
		
		/** Sound File */
		public static const FILETYPE_SOUND:FileType = new FileType(FILETYPE_SOUND_NAME);
		
		/** Library File */
		public static const FILETYPE_LIBRARY:FileType = new FileType(FILETYPE_LIBRARY_NAME);
		
		/** FileType values */
		public static const FILETYPE_SKIN_NAME:String				= "Skin";
		public static const FILETYPE_SOUND_NAME:String 				= "Sound";
		public static const FILETYPE_LIBRARY_NAME:String			= "Library";
		
		private static var _enumCreated:Boolean = false;
		
		private var _name:String;
		
		{
			_enumCreated = true;
		}
		
		public function FileType(name:String)
		{
			Assert.state((false == _enumCreated), "The FileType enum has already been created.");
			_name = name;
		}
		
		public static function fromName(name:String):FileType {
			var result:FileType;
	
			// check if the name is a valid value in the enum
			switch (StringUtils.trim(name.toUpperCase())) {
				case FILETYPE_SKIN_NAME.toUpperCase():
					result = FILETYPE_SKIN;
					break;
				case FILETYPE_SOUND_NAME.toUpperCase():
					result = FILETYPE_SOUND;
					break;
				case FILETYPE_LIBRARY_NAME.toUpperCase():
					result = FILETYPE_LIBRARY;
					break;
				default:
					break;
			}
		
			return result;
		}
	
		public function get name():String {
			return _name;
		}
	}
}