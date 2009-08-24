package org.flashmonkey.java.multiplayer.messages.processors;

import org.flashmonkey.java.api.IAvatar;
import org.flashmonkey.java.api.IPaperworldService;
import org.flashmonkey.java.api.IPlayer;
import org.flashmonkey.java.api.message.ISynchroniseCreateMessage;
import org.flashmonkey.java.multiplayer.messages.SynchroniseCreateMessage;

public class SynchroniseCreateMessageProcessor extends BroadcastMessageProcessor {

	public SynchroniseCreateMessageProcessor(IPaperworldService service) {
		super(service, SynchroniseCreateMessage.class);
	}
	
	@Override
	public Object process(Object object) {
		System.out.println("processing ISynchroniseCreateMessage " + ((ISynchroniseCreateMessage) object).getObjectId() + " " + ((ISynchroniseCreateMessage) object).getSenderId());
		
		ISynchroniseCreateMessage message = (ISynchroniseCreateMessage) object;
		//IPaperworldService service = getService();
		
		IPlayer player = service.getPlayer(message.getPlayerId());

		IAvatar avatar = player.getScopeObject();
		avatar.setId(message.getObjectId());

		service.registerAvatar(avatar);

		message.setInput(avatar.getInput());
		message.setState(avatar.getState());
		
		return super.process(object);
	}
}
