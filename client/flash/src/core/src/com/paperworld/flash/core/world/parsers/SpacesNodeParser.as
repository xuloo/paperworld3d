package com.paperworld.flash.core.world.parsers
{
	import com.paperworld.flash.core.space.SpaceContext;
	import com.paperworld.flash.core.world.World;
	import com.paperworld.flash.util.xml.AbstractNodeParser;
	import com.paperworld.flash.util.xml.IXMLDefinitionsParser;

	public class SpacesNodeParser extends AbstractNodeParser
	{
		public function SpacesNodeParser(xmlDefinitionsParser:IXMLDefinitionsParser)
		{
			super(xmlDefinitionsParser, WorldConstants.SPACES_ELEMENT);
		}
		
		override public function parse(world:World, node:XML):Object 
		{
			var defaultSpace:String = (node.@default == undefined) ? null : node.@default;
			
			for each (var space:XML in node.space)
			{
				var context:SpaceContext = new SpaceContext(space.@name, space.@location);
				context.isDefault = defaultSpace == space.@name;

				world.registerSpaceContext(context);
			}
			
			return null; 
		}
	}
}