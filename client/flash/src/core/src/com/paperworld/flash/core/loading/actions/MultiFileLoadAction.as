package com.paperworld.flash.core.loading.actions
{
	import com.paperworld.flash.core.action.Action;
	import com.paperworld.flash.core.action.CombinationAction;
	import com.paperworld.flash.core.space.files.FileDefinition;
	
	import flash.events.Event;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;

	public class MultiFileLoadAction extends CombinationAction
	{
		private static var logger:ILogger = LoggerFactory.getLogger("Paperworld(Core)");
		
		public function MultiFileLoadAction()
		{
			super();
		}
		
		public function addFile(file:FileDefinition):void 
		{
			file.addEventListener(Event.COMPLETE, _onActionComplete);
			
			file.next = subActions;
			subActions = file;
			
			_validateActions();
		}
		
		private function _validateActions():void 
		{
			var next:Action = subActions;
			
			while (next)
			{
				FileDefinition(next).queue = subActions;
				next = next.next;
			}
		}
		
		private function _onActionComplete(event:Event):void 
		{			
			if (isComplete)
			{
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		override public function get isComplete():Boolean
		{
			if (!super.isComplete)
			{
				var next:Action = subActions;
				
				while (next)
				{
					if (!next.isComplete)
					{
						next.act();
					}
					
					next = next.next;
				}
				
				return false;
			}
			
			return true;
		}
	}
}