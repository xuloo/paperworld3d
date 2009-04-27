package com.paperworld.java.impl.message.processors;

import com.paperworld.java.api.IAvatar;
import com.paperworld.java.api.IPaperworldService;
import com.paperworld.java.api.message.IPlayerSyncMessage;
import com.paperworld.java.impl.message.PlayerSyncMessage;

public class PlayerSyncMessageProcessor extends BaseMessageProcessor {

	public PlayerSyncMessageProcessor(IPaperworldService messageService) {
		super(messageService, IPlayerSyncMessage.class);
	}
	
	@Override
	public Object process(Object object) {
		PlayerSyncMessage message = (PlayerSyncMessage) object;

		IAvatar avatar = getService().getAvatar(message.getObjectId());
		avatar.updateUserInput(message.getTime(), message.getInput());
		
		return true;
	}
}
