package com.paperworld.java.impl.message.processors;

import java.util.Map;

import org.red5.server.api.service.ServiceUtils;

import com.paperworld.java.api.IPaperworldService;
import com.paperworld.java.api.IPlayer;
import com.paperworld.java.api.message.IMessage;

public class BroadcastMessageProcessor extends BaseMessageProcessor {

	public BroadcastMessageProcessor(IPaperworldService messageService) {
		super(messageService, IMessage.class);
	}

	public Object process(Object object) {
		IMessage message = (IMessage) object;

		Map<String, IPlayer> players = getService().getPlayers();

		for (String key : players.keySet()) {
			IPlayer player = players.get(key);
			if (!player.getName().equals(message.getSenderId())) {
				ServiceUtils.invokeOnConnection(player.getConnection(),
						"receiveMessage", new Object[] { message });
			}
		}
		
		return true;
	}
}
