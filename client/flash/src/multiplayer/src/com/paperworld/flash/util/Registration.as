package com.paperworld.flash.util
{
	import flash.net.registerClassAlias;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	public class Registration  
 	{  
 		public static var registeredClasses : Array = new Array( );  
   
 		public static function registerClass(instance : IRegisteredClass) : void  
 		{  
			var name : String = getQualifiedClassName( instance ).split( "::" ).join( "." );  
			   
			if (!isRegistered( name ))  
			{  
				var classObject : Class = getDefinitionByName( name ) as Class;  
				registerClassAlias( instance.aliasName, classObject );  
				registeredClasses.push( name );  
			}  
		}  
		   
		private static function isRegistered(name : String) : Boolean  
		{  
			var registered : Boolean = false;  
			   
			for each (var registeredName:String in registeredClasses)  
			{  
				if (registeredName == name)  
				{  
					registered = true;  
					break;  
				}  
			}  
			   
			return registered;  
		}  
	}  
}