package com.paperworld.flash.core.space
{
	import com.paperworld.flash.core.action.Action;
	import com.paperworld.flash.core.loading.actions.MultiFileLoadAction;
	import com.paperworld.flash.core.loading.actions.URLLoaderAction;
	import com.paperworld.flash.core.loading.interfaces.ILoadableAction;
	import com.paperworld.flash.core.space.files.FileDefinition;
	import com.paperworld.flash.core.space.parsers.SpaceDefinitionsParser;
	import com.paperworld.flash.util.patterns.iterator.IIterator;
	import com.paperworld.flash.util.xml.IXMLDefinitionsParser;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
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
		
		private var _xml:XML;
		
		private var _configLoadAction:Action;
		
		private var _fileLoadAction:MultiFileLoadAction;
		
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
			parser.addEventListener(SpaceDefinitionsParser.SCENE_PARSE_COMPLETE, _onSceneParseComplete, false, 0, true);
		}
		
		public function load():void 
		{
			loadConfig();
		}
		
		protected function loadConfig():void 
		{			
			_configLoadAction = new URLLoaderAction(configRequest);
			_configLoadAction.addEventListener(Event.COMPLETE, onConfigLoadComplete, false, 0, true);
			_configLoadAction.act();
		}
		
		private function _onFilesParseComplete(event:Event):void 
		{
			_fileLoadAction = new MultiFileLoadAction();
			var iterator:IIterator = _context.files;

			while (iterator.hasNext())
			{
				var file:FileDefinition = FileDefinition(iterator.next());

				_fileLoadAction.addFile(file)
			}
			
			_fileLoadAction.addEventListener(Event.COMPLETE, _onFilesLoadComplete);
			_fileLoadAction.act();
		}
		
		private function _onFilesLoadComplete(event:Event):void 
		{
			logger.info("files loaded");
			parser.parse(_xml);
		}
		
		private function _onSceneParseComplete(event:Event):void 
		{
			logger.info("scene parsed " + hasEventListener(Event.COMPLETE));
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		protected function onConfigLoadComplete(event:Event):void 
		{		
			_xml = new XML(ILoadableAction(event.target).data);

			_parser.parse(_xml);
		}
	}
}