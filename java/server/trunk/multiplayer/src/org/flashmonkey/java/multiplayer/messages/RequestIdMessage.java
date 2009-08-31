package org.flashmonkey.java.multiplayer.messages;

import org.flashmonkey.java.message.BaseMessage;


public class RequestIdMessage extends BaseMessage {

	public RequestIdMessage() {
		
	}
	
	public RequestIdMessage(String senderId) {
		super(senderId);
	}
}
