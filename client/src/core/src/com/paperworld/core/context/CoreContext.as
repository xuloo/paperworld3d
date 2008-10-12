package com.paperworld.core.context 
{
	import org.pranaframework.context.support.XMLApplicationContext;	

	/**
	 * @author Trevor
	 */
	public class CoreContext 
	{
		protected static var _instance : CoreContext;

		protected var _applicationContext : XMLApplicationContext;

		public function CoreContext()
		{
		}

		public static function getInstance() : CoreContext
		{
			return _instance = (_instance == null) ? new CoreContext( ) : _instance;	
		}

		public function getObject(name : String) : *
		{
			return _applicationContext.getObject( name );
		}

		public function getObjectWithConstructorArgs(name : String, args : Array) : *
		{
			return _applicationContext.getObject( name, args );
		}
	}
}
