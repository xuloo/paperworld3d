package org.flashmonkey.java.multiplayer.messages.processors;

import org.flashmonkey.java.api.message.IPlayerSyncMessage;
import org.flashmonkey.java.avatar.api.IAvatar;
import org.flashmonkey.java.connection.red5.service.api.IPaperworldService;
import org.flashmonkey.java.message.processor.BaseMessageProcessor;
import org.flashmonkey.java.multiplayer.messages.PlayerSyncMessage;

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
