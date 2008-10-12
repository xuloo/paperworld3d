package com.paperworld.multiplayer.data 
{
	import com.paperworld.core.BaseClass;
	import com.paperworld.input.Input;	

	/**
	 * @author Trevor
	 */
	public class TimedInput extends BaseClass 
	{
		public var time:int;
		
		public var input:Input;
		
		public function TimedInput(time:int = 0, input : Input = null)
		{
			super( );
			
			this.time = time;
			this.input = input;
		}
		
		public function getTime():int
		{
			return time;
		}
		
		public function setTime(time:int):void
		{
			this.time = time;	
		}
		
		public function getInput():Input
		{
			return input;
		}
		
		public function setInput(input:Input):void
		{
			this.input = input;	
		}
	}
}
