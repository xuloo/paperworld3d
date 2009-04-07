package com.paperworld.flash.core.space.events
{
	import flash.events.Event;
	
	import org.springextensions.actionscript.context.support.XMLApplicationContext;

	public class ParseEvent extends Event
	{
		public var context:XMLApplicationContext;
		
		public function ParseEvent(type:String, context:XMLApplicationContext, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			this.context = context;
		}
		
	}
}