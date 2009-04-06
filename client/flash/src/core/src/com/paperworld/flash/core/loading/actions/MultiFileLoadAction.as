package com.paperworld.flash.core.loading.actions
{
	import com.paperworld.flash.core.action.Action;
	import com.paperworld.flash.core.action.CombinationAction;
	
	import flash.events.Event;

	public class MultiFileLoadAction extends CombinationAction
	{
		public function MultiFileLoadAction()
		{
			super();
		}
		
		public function addLoadAction(action:Action):void 
		{
			action.addEventListener(Event.COMPLETE, _onActionComplete, false, 0, true);
			
			action.next = subActions;
			subActions = action;
		}
		
		private function _onActionComplete(event:Event):void 
		{
			if (isComplete)
			{
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
	}
}