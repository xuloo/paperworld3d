package com.paperworld.java.impl;

import org.red5.server.api.IConnection;
import org.red5.server.api.scheduling.IScheduledJob;
import org.red5.server.api.scheduling.ISchedulingService;
import org.red5.server.api.so.ISharedObject;

import com.paperworld.java.api.IPlayer;
import com.paperworld.java.api.message.IServerSyncMessage;
import com.paperworld.java.impl.message.ServerSyncMessage;

public class SimpleService extends AbstractPaperworldService {

	public SimpleService() {

	}

	public void init() {
		application.addScheduledJob(200, new UpdateConnectionsJob());
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
		return new BasicPlayer(username, connection);
	}

	private class UpdateConnectionsJob implements IScheduledJob {

		@Override
		public void execute(ISchedulingService service)
				throws CloneNotSupportedException {

			ISharedObject so = getSharedObject("avatars", false);

			so.beginUpdate();

			for (String key : players.keySet()) {
				IPlayer player = players.get(key);
				String id = player.getId();
				IServerSyncMessage syncMessage = new ServerSyncMessage(id, 0,
						player.getInput(), player.getAvatar().getState());
				so.setAttribute(id, syncMessage);
			}

			so.endUpdate();
		}

	}
}
