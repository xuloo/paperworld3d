package com.paperworld.flash.core.space.parsers
{
	import com.paperworld.flash.core.space.Space;
	import com.paperworld.flash.util.xml.IXMLDefinitionsParser;

	public class SpaceDefinitionsParser implements IXMLDefinitionsParser
	{
		private var _space:Space;
		
		public function SpaceDefinitionsParser(space:Space)
		{
			_space = space;
		}

		public function parse(xml:XML):void
		{
		}
		
	}
}