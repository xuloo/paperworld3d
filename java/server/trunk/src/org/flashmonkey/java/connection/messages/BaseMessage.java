package org.flashmonkey.java.connection.messages;

import org.flashmonkey.java.api.message.IMessage;
import org.flashmonkey.java.net.NetObject;
import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IDataOutput;

public class BaseMessage extends NetObject implements IMessage {

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
