package com.paperworld.flash.util.logging 
{
	import com.paperworld.flash.util.logging.Logger;
	
	/**
	 * @author Trevor
	 */
	public class BasicLogger implements Logger 
	{
		private var logger : *;

		public function BasicLogger(logger:*)
		{
			this.logger = logger;
		}

		public function isEnabled() : Boolean
		{
			return true;
		}
		
		public function info(msg : String, ...rest) : void
		{
			logger.info(msg);
		}
	}
}
