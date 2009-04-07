package com.paperworld.flash.core.space.parsers
{
	import com.paperworld.flash.core.space.SpaceContext;
	import com.paperworld.flash.core.space.events.ParseEvent;
	import com.paperworld.flash.core.space.parsers.postprocessors.ActorsPostProcessor;
	import com.paperworld.flash.core.space.parsers.postprocessors.IPostProcessor;
	import com.paperworld.flash.core.space.parsers.postprocessors.ViewsPostProcessor;
	import com.paperworld.flash.util.xml.INodeParser;
	import com.paperworld.flash.util.xml.IXMLDefinitionsParser;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;
	import org.springextensions.actionscript.context.support.XMLApplicationContext;

	public class SpaceDefinitionsParser extends EventDispatcher implements IXMLDefinitionsParser
	{
		private static var logger:ILogger = LoggerFactory.getLogger("Paperworld(Boot)");
		
		private static const STATE_UNPARSED:int = 0;
		private static const STATE_PARSING_FILES:int = 1;
		private static const STATE_FILES_PARSED:int = 2;
		private static const STATE_PARSING_OBJECTS:int = 3;
		private static const STATE_OBJECTS_PARSED:int = 4;
		
		public static const FILES_PARSE_COMPLETE:String = "FilesParseComplete";
		public static const OBJECTS_PARSE_COMPLETE:String = "SceneParseComplete";
		
		private var _state:int = STATE_UNPARSED;
		
		private var _context:SpaceContext;
		
		private var _nodeParsers:Array/*<INodeParser>*/ = [];
		
		private var _postProcessors:Array/*<IPostProcessor>*/ = [];
		
		public function SpaceDefinitionsParser(context:SpaceContext)
		{
			_context = context;
			_initPostProcessors();
		}

		public function parse(xml:XML):void
		{
			switch (_state)
			{
				case STATE_UNPARSED:
					_parseFiles(xml);
					break;
				
				case STATE_FILES_PARSED:
					_parseObjects(xml);
					break;
					
				default:
					break;
			}
		}
		
		private function _parseFiles(xml:XML):void 
		{
			_state = STATE_PARSING_FILES;
			
			_initFileNodeParsers();
			
			_parse(xml);
			
			_state = STATE_FILES_PARSED;
			
			dispatchEvent(new Event(FILES_PARSE_COMPLETE));
		}
		
		private function _initFileNodeParsers():void 
		{
			_clearNodeParsers();
			
			addNodeParser(new FilesNodeParser(this, _context));
		}
		
		private function _parseObjects(xml:XML):void 
		{
			_state = STATE_PARSING_OBJECTS;
			
			var objectsXML:XML = xml.objects[0];
						
			var context:XMLApplicationContext = new XMLApplicationContext();
			context.addEventListener(Event.COMPLETE, _onObjectsContextLoadComplete, false, 0, true);
			context.addConfig(objectsXML);
			context.load();
		}
		
		private function _onObjectsContextLoadComplete(event:Event):void 
		{			
			var context:XMLApplicationContext = XMLApplicationContext(event.target);
			
			_postProcess(context);
			
			_state = STATE_OBJECTS_PARSED;
			
			dispatchEvent(new ParseEvent(OBJECTS_PARSE_COMPLETE, XMLApplicationContext(event.target)));
		}
		
		private function _postProcess(context:XMLApplicationContext):void 
		{
			for each (var postProcessor:IPostProcessor in _postProcessors)
			{
				postProcessor.process(_context, context);
			}
		}
		
		private function _clearNodeParsers():void 
		{
			_nodeParsers = new Array();
		}
		
		private function _parse(xml:XML):void 
		{
			for each (var node:XML in xml.children())
			{
				_parseNode(node);	
			}
		}
		
		private function _parseNode(node:XML):void 
		{
			for (var i:int; i < _nodeParsers.length; i++)
			{
				var nodeParser:INodeParser = INodeParser(_nodeParsers[i]);
				if (nodeParser.canParse(node)) {
					nodeParser.parse(node);
					break;
				}
			}
		}
		
		public function addNodeParser(nodeParser:INodeParser):void 
		{
			_nodeParsers.push(nodeParser);
		}
		
		private function _initPostProcessors():void 
		{
			addPostProcessor(new ViewsPostProcessor());
			addPostProcessor(new ActorsPostProcessor());
		}
		
		public function addPostProcessor(postProcessor:IPostProcessor):void 
		{
			_postProcessors.push(postProcessor);
		}
		
	}
}