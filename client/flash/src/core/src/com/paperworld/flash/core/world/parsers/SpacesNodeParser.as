package com.paperworld.flash.core.world.parsers
{
	import com.paperworld.flash.core.space.SpaceContext;
	import com.paperworld.flash.core.world.World;
	import com.paperworld.flash.util.xml.IXMLDefinitionsParser;

	public class SpacesNodeParser extends AbstractWorldNodeParser
	{
		public function SpacesNodeParser(xmlDefinitionsParser:IXMLDefinitionsParser, world:World)
		{
			super(xmlDefinitionsParser, world, WorldConstants.SPACES_ELEMENT);
		}
		
		override public function parse(node:XML):Object 
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