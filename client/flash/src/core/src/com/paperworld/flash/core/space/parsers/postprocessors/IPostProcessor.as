package com.paperworld.flash.core.space.parsers.postprocessors
{
	import com.paperworld.flash.core.space.SpaceContext;
	
	import org.springextensions.actionscript.context.support.XMLApplicationContext;
	
	public interface IPostProcessor
	{
		function process(spaceContext:SpaceContext, appContext:XMLApplicationContext):void;
	}
}