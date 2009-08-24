package org.flashmonkey.java.multiplayer.messages.processors;

import java.util.Map;

import org.flashmonkey.java.api.IPaperworldService;
import org.flashmonkey.java.api.IPlayer;
import org.flashmonkey.java.api.message.IMessage;
import org.flashmonkey.java.connection.messages.processors.BaseMessageProcessor;

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
			System.out.println(player + " : " + message);
			//System.out.println(player.getId() + " : " + message.getSenderId() + " : " + player.getName().equals(message.getSenderId()));
			if (!player.getId().equals(message.getSenderId())) {
				player.sendMessage(message);
			}
		}
		
		return true;
	}
}
