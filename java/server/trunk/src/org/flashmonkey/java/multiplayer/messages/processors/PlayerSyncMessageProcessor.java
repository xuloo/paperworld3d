package org.paperworld.java.multiplayer.messages.processors;

import org.paperworld.java.api.IAvatar;
import org.paperworld.java.api.IPaperworldService;
import org.paperworld.java.api.message.IPlayerSyncMessage;
import org.paperworld.java.multiplayer.messages.PlayerSyncMessage;

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
