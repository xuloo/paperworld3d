package org.flashmonkey.java.service;

import org.flashmonkey.java.api.IAvatar;
import org.flashmonkey.java.api.IAvatarFactory;
import org.flashmonkey.java.api.IPlayer;
import org.flashmonkey.java.api.message.IServerSyncMessage;
import org.flashmonkey.java.avatar.factory.BasicAvatarFactory;
import org.flashmonkey.java.connection.messages.processors.RequestIdMessageProcessor;
import org.flashmonkey.java.core.objects.BasicState;
import org.flashmonkey.java.multiplayer.messages.ServerSyncMessage;
import org.flashmonkey.java.multiplayer.messages.processors.BatchedInputMessageProcessor;
import org.flashmonkey.java.multiplayer.messages.processors.SynchroniseCreateMessageProcessor;
import org.flashmonkey.java.player.BasicPlayer;
import org.red5.server.api.IConnection;
import org.red5.server.api.scheduling.IScheduledJob;
import org.red5.server.api.scheduling.ISchedulingService;
import org.red5.server.api.so.ISharedObject;

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
		System.out.println("before creating player");
		IPlayer player = createPlayer(username, connection);
		player.setConnection(connection);
		System.out.println("after creating player");
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
