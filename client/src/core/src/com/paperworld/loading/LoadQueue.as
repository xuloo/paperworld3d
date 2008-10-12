package com.paperworld.loading 
{
	import com.paperworld.core.EventDispatchingBaseClass;
	import com.paperworld.loading.requests.FileRequest;	

	/**
	 * @author Trevor
	 */
	public class LoadQueue extends EventDispatchingBaseClass 
	{
		public function LoadQueue()
		{
			super( this );
		}
		
		public function addRequest(request:FileRequest):void
		{
			
		}
		
		public function load():void
		{
			
		}
	}
}
