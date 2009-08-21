package org.paperworld.java.multiplayer.messages.processors;

import org.paperworld.java.api.IPaperworldService;
import org.paperworld.java.multiplayer.messages.RequestIdMessage;

public class RequestIdMessageProcessor extends BaseMessageProcessor {

	public RequestIdMessageProcessor(IPaperworldService messageService) {
		super(messageService, RequestIdMessage.class);
	}
	
	@Override
	public Object process(Object object) {
		System.out.println("Processing RequestIdMessage");
		RequestIdMessage message = (RequestIdMessage) object;
		
		String uniqueId = getService().getNextId(message.getSenderId());
		
		return uniqueId;
	}
}
