package com.paperworld.java.impl;

import org.red5.server.api.IConnection;
import org.red5.server.api.scheduling.IScheduledJob;
import org.red5.server.api.scheduling.ISchedulingService;
import org.red5.server.api.so.ISharedObject;

import com.paperworld.java.api.IAvatar;
import com.paperworld.java.api.IPlayer;
import com.paperworld.java.api.message.IServerSyncMessage;
import com.paperworld.java.api.message.ISynchroniseCreateMessage;
import com.paperworld.java.impl.message.ServerSyncMessage;
import com.paperworld.java.impl.message.processors.RequestIdMessageProcessor;
import com.paperworld.java.impl.message.processors.SynchroniseCreateMessageProcessor;

public class SimpleService extends AbstractPaperworldService {

	public SimpleService() {

	}

	public void init() {
		super.init();

		application.addScheduledJob(200, new UpdateConnectionsJob());

		addMessageProcessor(new RequestIdMessageProcessor(this));
		addMessageProcessor(new SynchroniseCreateMessageProcessor(this));
	}

	@Override
	public boolean appConnect(IConnection connection, Object[] args) {
		String uid = connection.getClient().getId();
		String username = args[0].toString();
		IPlayer player = createPlayer(username, connection);
		players.put(uid, player);
		idMap.put(uid, 0);
		return true;
	}

	protected IPlayer createPlayer(String username, IConnection connection) {
		return new BasicPlayer(this, username, connection);
	}

	public void processSynchroniseCreateMessage(
			ISynchroniseCreateMessage message) {
		IPlayer player = players.get(message.getPlayerId());
		
		IAvatar avatar = player.getAvatar();
		avatar.setId(message.getObjectId());
		avatar.setOwner(player);
		avatars.add(avatar);

		message.setInput(player.getInput());
		message.setState(avatar.getState());
	}

	public IAvatar getAvatarForPlayer(IPlayer player) {
		return new BasicAvatar();
	}

	private class UpdateConnectionsJob implements IScheduledJob {

		@Override
		public void execute(ISchedulingService service)
				throws CloneNotSupportedException {

			ISharedObject so = getSharedObject("avatars", false);

			so.beginUpdate();

			for (IAvatar avatar : avatars) {
				try {
					IPlayer player = avatar.getOwner();
					String id = player.getId();
					IServerSyncMessage syncMessage = new ServerSyncMessage(id, avatar.getId(),
							0, player.getInput(), avatar.getState());

					so.setAttribute(id, syncMessage);
				} catch (Exception e) {

				}
			}

			so.endUpdate();
		}

	}
}
