package com.paperworld.action {		/**
	 * @author Trevor
	 */
	public class TestAction extends Action 	{				public var destroyed:Boolean = false;					override public function destroy():void		{			destroyed = true;			}	}
}
