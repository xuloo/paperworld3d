package com.paperworld.flash.core.space.parsers
{
	import com.paperworld.flash.core.space.SpaceContext;
	import com.paperworld.flash.core.space.files.FileDefinition;
	import com.paperworld.flash.util.xml.IXMLDefinitionsParser;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;
	
	public class FilesNodeParser extends AbstractSpaceNodeParser
	{
		//private static var logger:ILogger = LoggerFactory.getLogger("Paperworld(Boot)");
		
		public function FilesNodeParser(xmlDefinitionsParser:IXMLDefinitionsParser, context:SpaceContext)
		{
			super(xmlDefinitionsParser, context, SpaceConstants.FILES_ELEMENT);
		}
		
		override public function parse(node:XML):Object 
		{
			for each (var xml:XML in node.file)
			{
				var fileDefinition:FileDefinition = new FileDefinition(xml.@type, xml.@location);

				space.registerFileDefinition(fileDefinition);
			}
			
			return null;
		}
	}
}