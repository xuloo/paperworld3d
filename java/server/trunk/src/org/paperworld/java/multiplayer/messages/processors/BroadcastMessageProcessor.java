package org.paperworld.java.multiplayer.messages.processors;

import java.util.Map;

import org.paperworld.java.api.IPaperworldService;
import org.paperworld.java.api.IPlayer;
import org.paperworld.java.api.message.IMessage;

public class BroadcastMessageProcessor extends BaseMessageProcessor {

	public BroadcastMessageProcessor(IPaperworldService messageService, Class<?> clazz) {
		super(messageService, clazz);
	}
	
	public BroadcastMessageProcessor(IPaperworldService messageService) {
		super(messageService);
	}

	public Object process(Object object) {
		System.out.println("processing BroadcastMessage");
		IMessage message = (IMessage) object;

		Map<String, IPlayer> players = getService().getPlayers();

		for (String key : players.keySet()) {
			IPlayer player = players.get(key);
			System.out.println(player.getId() + " : " + message.getSenderId() + " : " + player.getName().equals(message.getSenderId()));
			if (!player.getId().equals(message.getSenderId())) {
				player.sendMessage(message);
			}
		}
		
		return true;
	}
}
