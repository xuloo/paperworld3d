package org.paperworld.flash.connection.messages
{
	public class RequestIdMessage extends BaseMessage
	{			
		private var _uniqueId:String;
		
		public function RequestIdMessage()
		{
			super();
		}
		
		override public function onResult(result:Object):void
		{
			_uniqueId = String(result);
			
			super.onResult(result);
		}
		
		override public function read():* 
		{
			return _uniqueId;
		}
	}
}