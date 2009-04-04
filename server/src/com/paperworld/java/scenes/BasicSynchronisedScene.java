package com.paperworld.java.scenes;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.concurrent.CopyOnWriteArrayList;

import org.red5.server.api.IConnection;
import org.red5.server.api.ScopeUtils;
import org.red5.server.api.so.ISharedObject;
import org.red5.server.api.so.ISharedObjectService;

import com.paperworld.java.api.IInput;
import com.paperworld.java.api.ISynchronisedAvatar;
import com.paperworld.java.multiplayer.data.AvatarData;
import com.paperworld.java.multiplayer.data.SyncData;
import com.paperworld.java.multiplayer.objects.SynchronisedAvatar;
import com.paperworld.java.multiplayer.player.Player;

public class BasicSynchronisedScene extends AbstractSynchronisedScene {

	protected HashMap<String, Player> players;
	protected CopyOnWriteArrayList<ISynchronisedAvatar> avatars;

	public BasicSynchronisedScene() {
		players = new HashMap<String, Player>();
		avatars = new CopyOnWriteArrayList<ISynchronisedAvatar>();
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
		ISynchronisedAvatar avatar = (ISynchronisedAvatar) application
				.getContext().getBean("default.avatar");
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

		avatars.add(avatar);

		return new AvatarData(avatar);
	}

	/*
	 * @Override public int getAvatar(String key) { // ISynchronisedAvatar
	 * avatar = avatars.get(key); // System.out.println("avatar for " + key +
	 * " from " + avatars.size() + // " == " + avatar); return 0; }
	 */

	public SyncData receiveInput(String uid, IInput input) {
		ISynchronisedAvatar avatar = players.get(uid).getAvatar();

		avatar.setUserInput(input);

		avatar.updateSharedObject(getSharedObject());

		return new SyncData(getTime(), avatar.getAvatarData());
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

	/*
	 * public ArrayList<ISynchronisedAvatar> getAvatars() { return avatars; }
	 */

	public void setAvatar(ISynchronisedAvatar avatar) {
		if (avatar.getId() == null) {
			String id = "NULL_AVATAR_" + SynchronisedAvatar.COUNT++;
			System.out.println("setting id " + id);
			avatar.setId(id);
		}

		avatar.setScene(this);

		avatars.add(avatar);

	}

	/*
	 * public void setAvatars(ArrayList<ISynchronisedAvatar> avatars) {
	 * this.avatars = avatars; }
	 */
}