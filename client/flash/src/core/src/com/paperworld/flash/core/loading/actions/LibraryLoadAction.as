package com.paperworld.flash.core.loading.actions
{
	import com.paperworld.flash.core.space.files.FileDefinition;
	
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;

	public class LibraryLoadAction extends LoaderAction
	{
		private static var logger:ILogger = LoggerFactory.getLogger("Paperworld(Boot)");
		
		public function LibraryLoadAction(file:FileDefinition)
		{
			super(new URLRequest(file.location));
		}
		
		override protected function load():void 
		{
			if (urlRequest)
			{
				logger.info("loading " + urlRequest.url);
				loader.load(urlRequest, new LoaderContext(false, ApplicationDomain.currentDomain));
			}
		}
	}
}