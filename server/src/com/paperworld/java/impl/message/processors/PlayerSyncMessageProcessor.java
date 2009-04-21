package com.paperworld.java.impl.message.processors;

import com.paperworld.java.api.IPaperworldService;
import com.paperworld.java.api.message.IPlayerSyncMessage;

public class PlayerSyncMessageProcessor extends BaseMessageProcessor {

	public PlayerSyncMessageProcessor(IPaperworldService messageService) {
		super(messageService, IPlayerSyncMessage.class);
	}
}
