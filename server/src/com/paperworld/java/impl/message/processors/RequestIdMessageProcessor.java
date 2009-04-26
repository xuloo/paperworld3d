package com.paperworld.java.impl.message.processors;

import com.paperworld.java.api.IPaperworldService;
import com.paperworld.java.impl.message.RequestIdMessage;

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
