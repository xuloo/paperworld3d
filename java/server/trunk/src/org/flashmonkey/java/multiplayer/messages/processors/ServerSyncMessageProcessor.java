package org.flashmonkey.java.multiplayer.messages.processors;

import org.flashmonkey.java.api.IPaperworldService;
import org.flashmonkey.java.api.message.IServerSyncMessage;
import org.flashmonkey.java.connection.messages.processors.BaseMessageProcessor;

public class ServerSyncMessageProcessor extends BaseMessageProcessor {

	public ServerSyncMessageProcessor(IPaperworldService messageService) {
		super(messageService, IServerSyncMessage.class);
	}
}
