package com.paperworld.java.scenes;

import java.util.HashMap;

import org.red5.server.api.IConnection;
import org.red5.server.api.ScopeUtils;
import org.red5.server.api.so.ISharedObject;
import org.red5.server.api.so.ISharedObjectService;

import com.actionengine.api.IInput;
import com.paperworld.java.api.ISynchronisedAvatar;
import com.paperworld.multiplayer.data.AvatarData;
import com.paperworld.multiplayer.data.SyncData;
import com.paperworld.multiplayer.data.TimedInput;
import com.paperworld.multiplayer.player.Player;

public class BasicSynchronisedScene extends AbstractSynchronisedScene {

	protected HashMap<String, Player> players;
	protected HashMap<String, ISynchronisedAvatar> avatars;

	public BasicSynchronisedScene() {
		players = new HashMap<String, Player>();
		avatars = new HashMap<String, ISynchronisedAvatar>();
	}

	public void init() {

	}

	@Override
	public boolean appConnect(IConnection connection, Object[] params) {
		String name = (String) params[0];

		// Player player = new Player(name, connection);
		Player player = (Player) application.getContext().getBean(
				"default.player");

		player.setName(name);
		player.setConnection(connection);

		// IAvatar avatar = factory.getAvatar("default.avatar");
		ISynchronisedAvatar avatar = (ISynchronisedAvatar) application.getContext().getBean(
				"default.avatar");
		System.out.println("AVATAR: " + avatar);
		player.setAvatar(avatar);

		players.put(connection.getClient().getId(), player);

		return true;
	}

	@Override
	public void appDisconnect(IConnection connection) {

		Player player = getPlayerByConnection(connection);
		String id = player.getContext().getId();

		avatars.remove(id);
		players.remove(id);

		ISharedObject so = getSharedObject("avatars", false);
		so.removeAttribute(id);

		player.destroy();
	}

	@Override
	public AvatarData addPlayer(String id) {
		ISynchronisedAvatar avatar = players.get(id).getAvatar();
		
		avatar.setId(id);
		avatar.setKey("default.avatar");
		avatars.put(id, avatar);
		//System.out.println("adding avatar " + id);
		//return new SyncData(avatar.getTime(), 0, avatar.getInput(), avatar
		//		.getState());
		return new AvatarData(avatar);
	}

	@Override
	public int getAvatar(String key) {
		ISynchronisedAvatar avatar = avatars.get(key);
		System.out.println("avatar for " + key + " from " + avatars.size() + " == " + avatar);
		return 0;
	}

	public SyncData receiveInput(String uid, IInput input) {
		ISynchronisedAvatar avatar = players.get(uid).getAvatar();

		avatar.setUserInput(input);

		avatar.updateSharedObject(getSharedObject());

		return new SyncData(avatar.getTime(), input.getTime(), avatar.getInput(),
				avatar.getState());
	}

	public Player getPlayerByConnection(IConnection connection) {

		for (String key : players.keySet()) {

			Player player = players.get(key);

			if (player.getConnection() == connection) {

				return player;
			}
		}

		return null;
	}

	public ISharedObject getSharedObject(String name, boolean persistent) {

		ISharedObjectService service = (ISharedObjectService) ScopeUtils
				.getScopeService(application.getScope(),
						ISharedObjectService.class, false);
		return service
				.getSharedObject(application.getScope(), name, persistent);
	}

	public ISharedObject getSharedObject() {
		return getSharedObject("avatars", false);
	}

	public HashMap<String, Player> getPlayers() {
		return players;
	}

	public HashMap<String, ISynchronisedAvatar> getAvatars() {
		return avatars;
	}

	public void setAvatar(ISynchronisedAvatar avatar) {
		avatars.put(avatar.getId(), avatar);
	}

	public void setAvatars(HashMap<String, ISynchronisedAvatar> avatars) {
		this.avatars = avatars;
	}
}