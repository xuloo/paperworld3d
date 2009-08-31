package org.flashmonkey.java.multiplayer.messages.processors;

import org.flashmonkey.java.connection.red5.service.api.IPaperworldService;
import org.flashmonkey.java.message.processor.BaseMessageProcessor;
import org.flashmonkey.java.multiplayer.messages.RequestIdMessage;

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
