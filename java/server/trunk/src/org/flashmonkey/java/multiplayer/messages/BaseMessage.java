package org.paperworld.java.multiplayer.messages;

import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IDataOutput;

import org.paperworld.java.api.message.IMessage;

public class BaseMessage implements IMessage {

	private String senderId;
	
	public BaseMessage() {
		
	}
	
	public BaseMessage(String senderId) {
		this.senderId = senderId;
	}
	
	@Override
	public String getSenderId() {
		return senderId;
	}
	
	@Override
	public void setSenderId(String senderId) {
		this.senderId = senderId;
	}

	@Override
	public void readExternal(IDataInput input) {
		senderId = input.readUTF();
	}

	@Override
	public void writeExternal(IDataOutput output) {
		output.writeUTF(senderId);
	}

}
