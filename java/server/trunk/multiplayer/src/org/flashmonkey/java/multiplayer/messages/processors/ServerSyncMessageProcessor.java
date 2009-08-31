package org.flashmonkey.java.multiplayer.messages.processors;

import org.flashmonkey.java.api.message.IServerSyncMessage;
import org.flashmonkey.java.connection.red5.service.api.IPaperworldService;
import org.flashmonkey.java.message.processor.BaseMessageProcessor;

public class ServerSyncMessageProcessor extends BaseMessageProcessor {

	public ServerSyncMessageProcessor(IPaperworldService messageService) {
		super(messageService, IServerSyncMessage.class);
	}
}
