package com.paperworld.flash.core.world.parsers
{
	import com.paperworld.flash.core.world.World;
	import com.paperworld.flash.util.xml.AbstractNodeParser;
	import com.paperworld.flash.util.xml.IXMLDefinitionsParser;

	public class AbstractWorldNodeParser extends AbstractNodeParser
	{
		private var _world:World;
		
		public function get world():World
		{
			return _world;
		}
		
		public function AbstractWorldNodeParser(xmlDefinitionsParser:IXMLDefinitionsParser, world:World, nodeName:String)
		{
			super(xmlDefinitionsParser, nodeName);
			
			_world = world;
		}
		
	}
}