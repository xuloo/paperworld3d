package com.paperworld.java.multiplayer.messages.processors;

import com.paperworld.java.api.IAvatar;
import com.paperworld.java.api.IPaperworldService;
import com.paperworld.java.api.IPlayer;
import com.paperworld.java.api.message.ISynchroniseCreateMessage;
import com.paperworld.java.multiplayer.messages.SynchroniseCreateMessage;

public class SynchroniseCreateMessageProcessor extends BroadcastMessageProcessor {

	public SynchroniseCreateMessageProcessor(IPaperworldService service) {
		super(service, SynchroniseCreateMessage.class);
	}
	
	@Override
	public Object process(Object object) {
		System.out.println("processing ISynchroniseCreateMessage " + ((ISynchroniseCreateMessage) object).getObjectId());
		
		ISynchroniseCreateMessage message = (ISynchroniseCreateMessage) object;
		IPaperworldService service = getService();
		
		IPlayer player = service.getPlayer(message.getPlayerId());

		IAvatar avatar = player.getScopeObject();
		avatar.setId(message.getObjectId());

		service.registerAvatar(avatar);

		message.setInput(avatar.getInput());
		message.setState(avatar.getState());
		
		return super.process(object);
	}
}
