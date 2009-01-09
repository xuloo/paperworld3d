package com.paperworld.java.scenes;

import java.util.HashMap;
import java.util.Timer;
import java.util.TimerTask;

import org.red5.server.api.IConnection;
import org.red5.server.api.ScopeUtils;
import org.red5.server.api.so.ISharedObject;
import org.red5.server.api.so.ISharedObjectService;

import com.paperworld.multiplayer.data.SyncData;
import com.paperworld.multiplayer.data.TimedInput;
import com.paperworld.multiplayer.objects.Avatar;
import com.paperworld.multiplayer.player.Player;

public class SynchronisedSceneAdapter extends AbstractSceneAdapter {

	protected int frameRate;
	
	protected int clientUpdateRate;
	
	public int time = 0;
	
	protected HashMap<String, Player> players;
	protected HashMap<String, Avatar> avatars;
	
	protected Timer timer = new Timer("Timer", true);
	
	public SynchronisedSceneAdapter() {
		players = new HashMap<String, Player>();
		avatars = new HashMap<String, Avatar>();
	}
	
	public void init() {
		timer.scheduleAtFixedRate(new UpdateAvatarsTask(), 0, 1000 / frameRate);
		timer.scheduleAtFixedRate(new UpdateSharedObjectTask(), 0, 1000 / clientUpdateRate);
	}
	
	@Override
	public boolean appConnect(IConnection connection, Object[] params) {
		String name = (String) params[0];

		// Player player = new Player(name, connection);
		Player player = (Player) application.getContext().getBean(
				"default.player");
		player.setName(name);
		player.setConnection(connection);

		Avatar avatar = (Avatar) application.getContext().getBean(
				"default.avatar");

		avatar.time = time;

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
		player.destroy();
	}
	
	@Override
	public SyncData addPlayer(String id) {
		Avatar avatar = players.get(id).getAvatar();

		avatars.put(id, avatar);
		System.out.println("avatar " + avatar);
		
		return new SyncData(time, 0, avatar.input, avatar.state);
	}
	
	public SyncData receiveInput(String uid, TimedInput input) {
		Avatar avatar = players.get(uid).getAvatar();

		avatar.update(input);

		return new SyncData(time, input.time, avatar.input, avatar.state);
	}
	
	public int incrementTime() {
		return time++;
	}

	public int getTime() {
		return time;
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
	
	public void setFrameRate(int frameRate) {
		this.frameRate = frameRate;
	}
	
	public void setClientUpdateRate(int clientUpdateRate) {
		this.clientUpdateRate = clientUpdateRate;
	}
	
	public HashMap<String, Player> getPlayers() {
		return players;
	}
	
	public HashMap<String, Avatar> getAvatars() {
		return avatars;
	}
	
	public void setAvatar(Avatar avatar) {
		avatars.put(avatar.getAvatarData().getRef(), avatar);
	}

	public void setAvatars(HashMap<String, Avatar> avatars) {
		this.avatars = avatars;
	}

	protected class UpdateAvatarsTask extends TimerTask {

		@Override
		public void run() {
			time++;

			for (String key : avatars.keySet()) {
				avatars.get(key).update(time);
			}
		}
		
	}
	
	protected class UpdateSharedObjectTask extends TimerTask {

		@Override
		public void run() {
			ISharedObject so = getSharedObject("avatars", false);

			so.beginUpdate();

			for (String key : avatars.keySet()) {
				Avatar avatar = avatars.get(key);
				System.out.println("updating avatar " + avatar);
				so.setAttribute(key, new SyncData(time, avatar.getInput(), avatar.getState()));
			}

			so.endUpdate();			
		}
		
	}
}
