package com.paperworld.flash.util
{
	import flash.net.registerClassAlias;
	
	import org.as3commons.reflect.ClassUtils;
	
	public class Registration
	{
		private static var _registeredClasses:Array = [];
		
		public static function registerClass(instance:IRegisteredClass):void 
		{
			var clazz:Class = ClassUtils.forInstance(instance);
			
			if (!isRegistered(clazz))
			{
				registerClassAlias(instance.aliasName, clazz);
			}
		}
		
		private static function isRegistered(clazz:Class):Boolean 
		{
			for each (var registeredClass:Class in _registeredClasses)
			{
				if (registeredClass == clazz)
				{
					return true;
				}
			}	
			
			return false;
		}
	}
}