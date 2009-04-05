package com.paperworld.flash.core.space
{
	import com.paperworld.flash.core.loading.actions.AbstractLoadAction;
	import com.paperworld.flash.core.loading.actions.URLLoaderAction;
	import com.paperworld.flash.core.patterns.iterator.IIterator;
	import com.paperworld.flash.core.space.files.FileDefinition;
	import com.paperworld.flash.core.space.parsers.SpaceDefinitionsParser;
	import com.paperworld.flash.util.xml.IXMLDefinitionsParser;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;

	public class SpaceLoader extends EventDispatcher
	{
		private static var logger:ILogger = LoggerFactory.getLogger("Paperworld");
		
		private var _parser:IXMLDefinitionsParser;
		
		protected function get parser():SpaceDefinitionsParser
		{
			return SpaceDefinitionsParser(_parser);
		}
		
		private var _context:SpaceContext;
		
		public function get spaceName():String 
		{
			return _context.name;
		}
		
		public function get configRequest():URLRequest 
		{
			return new URLRequest(spaceName + ".xml");
		}
		
		public function SpaceLoader(context:SpaceContext)
		{
			super(this);
			
			_context = context;
			
			_initialise();
		}
		
		private function _initialise():void 
		{
			_parser = new SpaceDefinitionsParser(_context);
			parser.addEventListener(SpaceDefinitionsParser.FILES_PARSE_COMPLETE, _onFilesParseComplete, false, 0, true);
		}
		
		public function load():void 
		{
			loadConfig();
		}
		
		protected function loadConfig():void 
		{
			var configLoadAction:URLLoaderAction = new URLLoaderAction(configRequest);
			configLoadAction.addEventListener(Event.COMPLETE, onConfigLoadComplete, false, 0, true);
			configLoadAction.load();
		}
		
		private function _onFilesParseComplete(event:Event):void 
		{
			var loader:AbstractLoadAction;
			var iterator:IIterator = _context.files;

			while (iterator.hasNext())
			{
				var file:FileDefinition = FileDefinition(iterator.next());
				var loaderAction:AbstractLoadAction = FileDefinition.getFileLoader(file);
				
				if (!loader)
				{
					loader = loaderAction;
				}
				else
				{
					loader.subActions.next = loaderAction;
				}
			}
			
			loader.addEventListener(Event.COMPLETE, _onFilesLoadComplete, false, 0, true);
			loader.load();
		}
		
		private function _onFilesLoadComplete(event:Event):void 
		{
			logger.info("files loaded");
		}
		
		protected function onConfigLoadComplete(event:Event):void 
		{			
			logger.info("data: " + URLLoader(event.target).data);
			
			var xml:XML = new XML(URLLoader(event.target).data);
			logger.info("parser: " + _parser);
			_parser.parse(xml);
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}