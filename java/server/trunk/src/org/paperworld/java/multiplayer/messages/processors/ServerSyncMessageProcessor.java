package org.paperworld.java.multiplayer.messages.processors;

import org.paperworld.java.api.IPaperworldService;
import org.paperworld.java.api.message.IServerSyncMessage;

public class ServerSyncMessageProcessor extends BaseMessageProcessor {

	public ServerSyncMessageProcessor(IPaperworldService messageService) {
		super(messageService, IServerSyncMessage.class);
	}
}
