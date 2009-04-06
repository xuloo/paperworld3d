package com.paperworld.flash.core.loading.actions
{
	import com.paperworld.flash.core.loading.handlers.SkinFileLoadCompleteHandler;
	import com.paperworld.flash.core.space.files.FileDefinition;
	
	import flash.net.URLRequest;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;
	
	public class SkinLoadAction extends LoaderAction
	{
		private static var logger:ILogger = LoggerFactory.getLogger("Paperworld(Boot)");
		
		override public function get data():*
		{
			return loader;
		}
		
		public function SkinLoadAction(file:FileDefinition)
		{
			super(new URLRequest(file.location));
			
			loadCompleteHandler = new SkinFileLoadCompleteHandler();
		}
	}
}