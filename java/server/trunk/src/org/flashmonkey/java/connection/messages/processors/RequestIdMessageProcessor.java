package org.flashmonkey.java.connection.messages.processors;

import org.flashmonkey.java.api.IPaperworldService;
import org.flashmonkey.java.connection.messages.RequestIdMessage;

public class RequestIdMessageProcessor extends BaseMessageProcessor {

	public RequestIdMessageProcessor(IPaperworldService messageService) {
		super(messageService, RequestIdMessage.class);
	}
	
	@Override
	public Object process(Object object) {

		RequestIdMessage message = (RequestIdMessage) object;

		String uniqueId = getService().getNextId(message.getSenderId());

		return uniqueId;
	}
}
