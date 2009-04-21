package com.paperworld.java.impl.message.processors;

import org.red5.server.api.service.ServiceUtils;

import com.paperworld.java.api.IPaperworldService;
import com.paperworld.java.api.IPlayer;
import com.paperworld.java.api.message.IPlayerMessage;

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
