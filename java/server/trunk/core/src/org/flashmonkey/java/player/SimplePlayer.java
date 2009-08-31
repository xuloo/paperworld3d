package org.flashmonkey.java.player;

import java.util.List;

import org.flashmonkey.java.avatar.api.IAvatar;
import org.flashmonkey.java.message.api.IMessage;
import org.red5.server.api.IConnection;

public class SimplePlayer extends AbstractPlayer {

	protected IConnection connection;
	
	public SimplePlayer(IConnection connection, String name) {
		this.connection = connection;
		this.name = name;
	}
	
	@Override
	public void performScopeQuery(List<IAvatar> avatars) {
		// TODO Auto-generated method stub

	}

	@Override
	public boolean sendMessage(IMessage message) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public String getId() {
		return connection.getClient().getId();
	}

}
