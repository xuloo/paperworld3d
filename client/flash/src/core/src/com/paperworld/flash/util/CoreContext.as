package com.paperworld.flash.util
{
	import org.springextensions.actionscript.context.support.XMLApplicationContext;
	
	public class CoreContext
	{
		private var _applicationContext:XMLApplicationContext;
		
		public function CoreContext()
		{
		}
		
		public static function getInstance():CoreContext
		{
			return null;
		}
		
		public function getObject(id:String, args:Array = null):*
		{
			return null;
		}
	}
}