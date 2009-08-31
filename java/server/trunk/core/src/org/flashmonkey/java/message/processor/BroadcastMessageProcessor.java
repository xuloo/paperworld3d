package org.flashmonkey.java.message.processor;

import java.util.Map;

import org.flashmonkey.java.connection.red5.service.api.IPaperworldService;
import org.flashmonkey.java.message.api.IMessage;
import org.flashmonkey.java.player.api.IPlayer;

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
