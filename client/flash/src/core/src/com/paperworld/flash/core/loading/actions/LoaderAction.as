package com.paperworld.flash.core.loading.actions
{
	import com.paperworld.flash.core.loading.interfaces.ILoadableAction;
	
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	import mx.messaging.config.ConfigMap;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;

	public class LoaderAction extends AbstractLoadAction implements ILoadableAction
	{		
		private static var logger:ILogger = LoggerFactory.getLogger("Paperworld(Boot)");
		
		private var _loader:Loader;
		
		public function get loader():*
		{
			if (!_loader)
			{
				_loader = new Loader();
				configureListeners(_loader.contentLoaderInfo);
			}
			
			return _loader;
		}
		
		override public function get data():*
		{
			return loader.contentLoaderInfo.content;
		}
		
		override public function get bytesLoaded():int 
		{
			var bytes:int = loader.contentLoaderInfo.bytesLoaded;
			
			if (next)
			{
				return bytes + AbstractLoadAction(next).bytesLoaded;
			}
			
			return bytes;
		}
		
		override public function get bytesTotal():int 
		{
			var bytes:int = loader.contentLoaderInfo.bytesTotal;
			
			if (next)
			{
				return bytes + AbstractLoadAction(next).bytesTotal;
			}
			
			return bytes;
		}
		
		public function LoaderAction(urlRequest:URLRequest = null)
		{
			super(urlRequest);
		}
		
		protected function getLoaderContext():LoaderContext
		{
			return null;
		}
		
		override protected function load():void 
		{
			if (urlRequest)
			{
				logger.info("loading " + urlRequest.url);
				loader.load(urlRequest);
			}
		}
	}
}