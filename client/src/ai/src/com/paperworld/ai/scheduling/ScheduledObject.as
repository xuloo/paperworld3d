package com.paperworld.ai.scheduling 
{
	import com.paperworld.action.Action;
	import com.paperworld.core.BaseClass;		
	/**
	 * @author Trevor
	 */
	public class ScheduledObject extends BaseClass implements Scheduleable
	{
		public var behaviour:Action;
		
		public var frequency:int;
		
		public var phase:int;
		
		public var priority : int;
		
		public function run(time : int = 0) : void
		{
		}
	}
}
