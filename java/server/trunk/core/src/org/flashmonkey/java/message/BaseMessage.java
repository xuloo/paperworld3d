package org.flashmonkey.java.message;

import org.flashmonkey.java.core.net.NetObject;
import org.flashmonkey.java.message.api.IMessage;
import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IDataOutput;

public class BaseMessage extends NetObject implements IMessage {

	protected String senderId;
	
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
