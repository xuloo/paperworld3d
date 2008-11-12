package com.paperworld.ai.scheduling 
{
	import com.paperworld.core.BaseClass;
	
	import de.polygonal.ds.HashMap;	

	/**
	 * @author Trevor
	 */
	public class BehaviourSet extends BaseClass
	{
		public var functionLists:HashMap;
		
		public var frequency:int = 0;
		
		public function BehaviourSet()
		{
			super();	
		}
		
		override public function initialise():void
		{
			functionLists = new HashMap();	
		}
	}
}
