package org.flashmonkey.java.multiplayer.messages.processors;

import org.flashmonkey.java.api.message.IPlayerMessage;
import org.flashmonkey.java.connection.red5.service.api.IPaperworldService;
import org.flashmonkey.java.message.processor.BaseMessageProcessor;
import org.flashmonkey.java.player.api.IPlayer;

public class PlayerMessageProcessor extends BaseMessageProcessor {

	public PlayerMessageProcessor(IPaperworldService messageService) {
		super(messageService, IPlayerMessage.class);
	}

	public Object process(Object object) {
		IPlayerMessage message = (IPlayerMessage) object;

		IPlayer player = getService().getPlayers().get(message.getPlayerId());

		return true;//ServiceUtils.invokeOnConnection(player.getConnection(),
				//"receiveMessage", new Object[] { message });
	}
}
