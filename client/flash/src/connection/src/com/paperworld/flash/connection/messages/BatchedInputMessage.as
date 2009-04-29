package com.paperworld.flash.connection.messages
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	
	public class BatchedInputMessage extends BaseMessage
	{
		override public function get aliasName():String
		{
			return "com.paperworld.java.impl.message.BatchedInputMessage";
		}
		
		private var _messages:Array = [];
		
		public function set messages(value:Array):void 
		{
			_messages = value;
			
			for each (var message:PlayerSyncMessage in _messages) {
				trace(message.input.moveForward);
			}
		}
		
		public function BatchedInputMessage()
		{
			super();
		}
		
		override public function readExternal(input:IDataInput):void
		{
			super.readExternal(input);
			
			var length:int = input.readInt();
			
			for (var i:int = 0; i < length; i++)
			{
				_messages.push(input.readObject());
			}
		}
		
		override public function writeExternal(output:IDataOutput):void 
		{
			super.writeExternal(output);
		
			output.writeInt(_messages.length);
			
			for (var i:int = 0; i < _messages.length; i++)
			{
				output.writeObject(_messages[i]);
			}
		}
		
	}
}