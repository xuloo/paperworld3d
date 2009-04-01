package com.paperworld.flash.util.logging 
{
	import com.paperworld.flash.util.logging.Logger;
	
	/**
	 * @author Trevor
	 */
	public class NullLogger implements Logger 
	{
		public function info(msg : String, ...rest) : void
		{
		}
		
		public function isEnabled() : Boolean
		{
			return false;
		}
	}
}
