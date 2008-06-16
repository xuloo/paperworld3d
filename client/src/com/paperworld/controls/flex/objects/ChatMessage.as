package com.paperworld.controls.flex.objects
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	
	 [RemoteClass(alias="com.paperworld.chat.ChatMessage")]

	public class ChatMessage implements IExternalizable
	{
		public var username:String;
		
		public var message:String;
		
		public var count:int;
		
		public var timeStamp:int;
		
		public var isDisplayed:Boolean = false;
		
		public function ChatMessage()
		{
		}

		public function writeExternal(output:IDataOutput):void
		{
			output.writeUTF(username);
			output.writeUTF(message);
			output.writeInt(count);
			output.writeUnsignedInt(timeStamp);
		}
		
		public function readExternal(input:IDataInput):void
		{
			username = input.readUTF();
			message = input.readUTF();
			count = input.readInt();
			timeStamp = input.readUnsignedInt();
		}
		
		public function toString():String 
		{
			return username + " : " + message;
		}
	}
}