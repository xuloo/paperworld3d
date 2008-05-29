package com.paperworld.scenes;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import org.red5.server.api.IConnection;

import com.paperworld.core.player.Player;

public class SceneManager {

	private Map<String, RemoteScene> scenes = new HashMap<String, RemoteScene>();

	private Map<String, Player> players = new HashMap<String, Player>();

	public SceneManager() {

	}

	public void addScene(RemoteScene scene) {
		scenes.put(scene.getName(), scene);
	}
	
	public void addPlayer(Player player) {
		players.put(player.getUsername(), player);
	}

	public void addPlayerToScene(String playerKey, String sceneKey) {
		System.out.println("players " + players.toString());
		addPlayerToScene(players.get(playerKey), sceneKey);
	}

	public void addPlayerToScene(Player player, String sceneKey) {
		removePlayerFromScene(player);
		System.out.println("adding " + player.avatar );
		RemoteScene scene = scenes.get(sceneKey);
		scene.addPlayer(player);
		player.setScene(scene);
	}
	
	public void removePlayerFromScene(Player player) {
		RemoteScene scene = player.getScene();
		if (scene != null) {
			scene.removePlayer(player);
			player.setScene(null);
		}
	}
	
	public void removePlayer(Player player) {
		removePlayerFromScene(player);	
		players.remove(player);
	}

	public boolean sceneExists(String key) {
		return scenes.containsKey(key);
	}
	
	public RemoteScene getScene(String key) {
		return scenes.get(key);
	}

	public Map<String, RemoteScene> getScenes() {
		return scenes;
	}
	
	public void setScenes(Map<String, RemoteScene> scenes) {
		this.scenes = scenes;
	}
	
	public RemoteScene[] getScenesArray() {
		RemoteScene[] a = new RemoteScene[scenes.size()];
		return (RemoteScene[]) scenes.values().toArray(a);
	}
	
	public Player getPlayer(String key) {
		System.out.println("SM getting player " + players.get(key) + " == " + players.get(key).avatar);
		return players.get(key);
	}
	
	public Player getPlayer(IConnection connection) {
		for (String key : players.keySet()) {
			Player player = players.get(key);
			if (player.getConnection().equals(connection)) {
				return player;
			}
		}
		
		return null;
	}
	
	public Map<String, Player> getPlayers() {
		return players;
	}
	
	public Player[] getPlayersArray() {
		Player[] a = new Player[players.size()];
		return players.values().toArray(a);
	}
}
