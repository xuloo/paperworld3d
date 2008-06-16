package com.paperworld.chat;

import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IDataOutput;
import org.red5.io.amf3.IExternalizable;

public class ChatMessage implements IExternalizable {

	public String username;
	
	public String message;
	
	public int count = 0;
	
	public long timeStamp;
	
	public ChatMessage() {
		
	}
	
	public ChatMessage(String username, String message, int count) {
		this.username = username;
		this.message = message;
		this.count = count;
	}

	public void readExternal(IDataInput input) {
		username = input.readUTF();
		message = input.readUTF();
		count = input.readInt();
		timeStamp = input.readUnsignedInt();
	}

	public void writeExternal(IDataOutput output) {
		output.writeUTF(username);
		output.writeUTF(message);
		output.writeInt(count);
		output.writeUnsignedInt(timeStamp);
	}
}
