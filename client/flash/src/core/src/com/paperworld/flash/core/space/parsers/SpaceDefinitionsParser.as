package com.paperworld.flash.core.space.parsers
{
	import com.paperworld.flash.core.space.SpaceContext;
	import com.paperworld.flash.util.xml.INodeParser;
	import com.paperworld.flash.util.xml.IXMLDefinitionsParser;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;

	public class SpaceDefinitionsParser extends EventDispatcher implements IXMLDefinitionsParser
	{
		private static var logger:ILogger = LoggerFactory.getLogger("Paperworld(Boot)");
		
		private static const STATE_UNPARSED:int = 0;
		private static const STATE_PARSING_FILES:int = 1;
		private static const STATE_FILES_PARSED:int = 2;
		private static const STATE_PARSING_SCENE:int = 3;
		private static const STATE_SCENE_PARSED:int = 4;
		
		public static const FILES_PARSE_COMPLETE:String = "FilesParseComplete";
		
		private var _state:int = STATE_UNPARSED;
		
		private var _context:SpaceContext;
		
		private var _nodeParsers:Array/*<INodeParser>*/ = [];
		
		public function SpaceDefinitionsParser(context:SpaceContext)
		{
			_context = context;
		}

		public function parse(xml:XML):void
		{
			switch (_state)
			{
				case STATE_UNPARSED:
					_parseFiles(xml);
					break;
				
				case STATE_FILES_PARSED:
					_parseScene(xml);
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
			
			dispatchEvent(new Event(FILES_PARSE_COMPLETE));
		}
		
		private function _initFileNodeParsers():void 
		{
			_clearNodeParsers();
			
			addNodeParser(new FilesNodeParser(this, _context));
		}
		
		private function _parseScene(xml:XML):void 
		{
			_state = STATE_PARSING_SCENE;
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
		
	}
}