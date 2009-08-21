package org.paperworld.java.multiplayer.messages.processors;

import org.paperworld.java.api.IPaperworldService;
import org.paperworld.java.api.IPlayer;
import org.paperworld.java.api.message.IPlayerMessage;
import org.red5.server.api.service.ServiceUtils;

public class PlayerMessageProcessor extends BaseMessageProcessor {

	public PlayerMessageProcessor(IPaperworldService messageService) {
		super(messageService, IPlayerMessage.class);
	}

	public Object process(Object object) {
		IPlayerMessage message = (IPlayerMessage) object;

		IPlayer player = getService().getPlayers().get(message.getPlayerId());

		return ServiceUtils.invokeOnConnection(player.getConnection(),
				"receiveMessage", new Object[] { message });
	}
}
