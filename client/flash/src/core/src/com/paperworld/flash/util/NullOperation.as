package com.paperworld.flash.util
{
	import flash.events.IEventDispatcher;
	import org.springextensions.actionscript.mvcs.service.operation.AbstractOperation;

	public class NullOperation extends AbstractOperation
	{
		public function NullOperation()
		{
			super(this);
		}
		
		override public function execute():void
		{
			dispatchResult(this);
		}
	}
}