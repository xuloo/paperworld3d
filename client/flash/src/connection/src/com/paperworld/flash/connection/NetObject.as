package com.paperworld.flash.connection
{
	import com.paperworld.flash.util.Constants;
	import com.paperworld.flash.util.IRegisteredClass;
	import com.paperworld.flash.util.Registration;
	
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	
	import org.as3commons.reflect.ClassUtils;
	import org.springextensions.actionscript.utils.StringUtils;

	public class NetObject implements IExternalizable, IRegisteredClass
	{
		/**
		 * @private
		 */
		private var _aliasName:String;
		
		/**
		 * Default behaviour for returning the remote alias for this class.
		 * We just replace the word 'java' with the word 'flash' in the package path.
		 * This relies on the server-side package structure being identical (apart
		 * from the flash/java replacement) so if you don't follow this convention
		 * in your application you'll need to override the createAliasName() 
		 * method in your objects that are being passed over the wire.
		 */
		public function get aliasName():String
		{
			// If we don't already have the alias name cached.
			if (!aliasName)
			{
				// Create and cache it.
				_aliasName = createAliasName();
			}
			
			return _aliasName;
		}
		
		protected function createAliasName():String
		{
			var className:String = ClassUtils.getFullyQualifiedName(ClassUtils.forInstance(this), true);
			var java:String = Constants.JAVA_STRING;
			var beginIndex:int = _aliasName.indexOf(java);
			var endIndex:int = beginIndex + java.length;
			
			return StringUtils.replaceAt(_aliasName, Constants.FLASH_STRING, beginIndex, endIndex);
		}
		
		public function NetObject()
		{
			Registration.registerClass(this);
		}

		public function writeExternal(output:IDataOutput):void
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
		}	
	}
}