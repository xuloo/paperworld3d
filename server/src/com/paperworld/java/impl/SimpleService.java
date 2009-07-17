package com.paperworld.java.impl;

import org.red5.server.api.IConnection;
import org.red5.server.api.scheduling.IScheduledJob;
import org.red5.server.api.scheduling.ISchedulingService;
import org.red5.server.api.so.ISharedObject;

import com.paperworld.java.api.IAvatar;
import com.paperworld.java.api.IAvatarFactory;
import com.paperworld.java.api.IPlayer;
import com.paperworld.java.api.message.IServerSyncMessage;
import com.paperworld.java.api.message.ISynchroniseCreateMessage;
import com.paperworld.java.multiplayer.messages.ServerSyncMessage;
import com.paperworld.java.multiplayer.messages.processors.BatchedInputMessageProcessor;
import com.paperworld.java.multiplayer.messages.processors.RequestIdMessageProcessor;
import com.paperworld.java.multiplayer.messages.processors.SynchroniseCreateMessageProcessor;

public class SimpleService extends AbstractPaperworldService {

	protected IAvatarFactory factory = new BasicAvatarFactory();
	
	public SimpleService() {

	}

	public void init() {
		super.init();

		application.addScheduledJob(200, new UpdateConnectionsJob());
		application.addScheduledJob(100, new UpdateAvatarsJob());

		addMessageProcessor(new RequestIdMessageProcessor(this));
		addMessageProcessor(new SynchroniseCreateMessageProcessor(this));
		addMessageProcessor(new BatchedInputMessageProcessor(this));
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

	public IPlayer getPlayer(String id) {
		return players.get(id);
	}
	
	public void registerAvatar(IAvatar avatar) {
		avatars.put(avatar.getId(), avatar);
	}

	@Override
	public IAvatar getAvatar(String objectId) {
		return avatars.get(objectId);
	}

	private class UpdateConnectionsJob implements IScheduledJob {

		@Override
		public void execute(ISchedulingService service)
				throws CloneNotSupportedException {

			ISharedObject so = getSharedObject("avatars", false);

			so.beginUpdate();

			for (String key : avatars.keySet()) {
				IAvatar avatar = avatars.get(key);
				try {
					IPlayer player = avatar.getOwner();
					String id = player.getId();
					BasicState state = avatar.getState();
					System.out.println(avatar + " position" + state.px + " " + state.py + " " + state.pz);
					IServerSyncMessage syncMessage = new ServerSyncMessage(id,
							avatar.getId(), avatar.getTime(), avatar.getInput(), avatar
									.getState());

					so.setAttribute(id, syncMessage);
				} catch (Exception e) {

				}
			}

			so.endUpdate();
		}

	}
	
	private class UpdateAvatarsJob implements IScheduledJob {

		@Override
		public void execute(ISchedulingService service)
				throws CloneNotSupportedException {
			for (String key : avatars.keySet()) {
				avatars.get(key).update();
			}
		}		
	}

	@Override
	public IAvatarFactory getFactory() {
		return factory;
	}

	@Override
	public void setAvatarFactory(IAvatarFactory factory) {
		this.factory = factory;
	}
}
