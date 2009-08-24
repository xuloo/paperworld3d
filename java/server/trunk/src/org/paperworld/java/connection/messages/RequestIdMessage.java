package org.paperworld.java.connection.messages;

import org.paperworld.java.multiplayer.messages.BaseMessage;

public class RequestIdMessage extends BaseMessage {

	public RequestIdMessage() {
		
	}
	
	public RequestIdMessage(String senderId) {
		super(senderId);
	}
}
