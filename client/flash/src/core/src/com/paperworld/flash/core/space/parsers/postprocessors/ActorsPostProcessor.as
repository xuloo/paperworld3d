package com.paperworld.flash.core.space.parsers.postprocessors
{
	import com.paperworld.flash.core.space.SpaceContext;
	import org.springextensions.actionscript.context.support.XMLApplicationContext;

	public class ActorsPostProcessor implements IPostProcessor
	{
		public function process(spaceContext:SpaceContext, appContext:XMLApplicationContext):void
		{
			for each (var name:String in appContext.objectDefinitionNames)
			{
				var split:Array = name.split(".");
				
				if (split.length > 1)
				{
					var last:String = split[split.length - 1];
					
					if (last == "actor")
					{
						spaceContext.addActor(appContext.getObject(name));
					}
				}
			}
		}
		
	}
}