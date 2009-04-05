package com.paperworld.flash.core.space.parsers
{
	import com.paperworld.flash.core.space.SpaceContext;
	import com.paperworld.flash.util.xml.AbstractNodeParser;
	import com.paperworld.flash.util.xml.IXMLDefinitionsParser;

	public class AbstractSpaceNodeParser extends AbstractNodeParser
	{
		private var _context:SpaceContext;
		
		public function get space():SpaceContext 
		{
			return _context;
		}
		
		public function AbstractSpaceNodeParser(xmlDefinitionsParser:IXMLDefinitionsParser, context:SpaceContext, nodeName:String)
		{
			super(xmlDefinitionsParser, nodeName);
			
			_context = context;
		}
		
	}
}