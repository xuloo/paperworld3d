package com.paperworld.core.player;

import java.util.HashMap;

import org.red5.server.api.IConnection;

public class PlayerManager {
	
	private HashMap<String, Player> players = new HashMap<String, Player>();

	public PlayerManager() {

	}

	public Player get(String key) {
		return players.get(key);
	}

	public Player put(String key, Player value) {
		return players.put(key, value);
	}

	public Player get(IConnection conn) {
		
		System.out.println("getting player for " + conn);
		
		for (String key : players.keySet()) {
			Player player = (Player) players.get(key);

			if (player.getConnection().equals(conn)) {
				System.out.println("getting " + player);
				return player;
			}
		}

		return null;
	}

	public void clear() {
		players.clear();
	}

	public boolean containsKey(Object key) {
		return players.containsKey(key);
	}

	public boolean containsValue(Object value) {
		return players.containsValue(value);
	}

	/*public Set<java.util.Map.Entry<String, Player>> entrySet() {
		// TODO Auto-generated method stub
		return null;
	}*/

	/*
	 * public Player get(Object key) { return players.get(key); }
	 */

	/*public boolean isEmpty() {
		return players.isEmpty();
	}*/

	/*public Set<String> keySet() {
		return null;
	}*/

	/*public void putAll(Map<? extends String, ? extends Player> t) {
		// TODO Auto-generated method stub

	}*/

	public Player remove(Object key) {
		return players.remove(key);
	}

	public int size() {
		return players.size();
	}

	/*public Collection<Player> values() {
		// TODO Auto-generated method stub
		return null;
	}*/
}
