package com.paperworld.flash.core.world.parsers
{
	import com.paperworld.flash.core.world.World;
	import com.paperworld.flash.util.xml.INodeParser;
	import com.paperworld.flash.util.xml.IXMLDefinitionsParser;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;
	
	public class WorldDefinitionParser implements IXMLDefinitionsParser
	{
		private static var logger:ILogger = LoggerFactory.getLogger("Paperworld(Boot)");
		
		private var _nodeParsers:Array/*<INodeParser>*/ = [];
		
		private var _world:World;
		
		public function WorldDefinitionParser(world:World)
		{
			_world = world;
			
			_initialise();
		}

		private function _initialise():void 
		{
			addNodeParser(new SpacesNodeParser(this));
		}
		
		public function addNodeParser(nodeParser:INodeParser):void 
		{
			_nodeParsers.push(nodeParser);
		}
		
		public function parse(xml:XML):void 
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
					nodeParser.parse(_world, node);
					break;
				}
			}
		}
	}
}