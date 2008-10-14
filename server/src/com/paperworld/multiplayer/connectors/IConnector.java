package com.paperworld.multiplayer.connectors;

import java.util.HashMap;

import org.red5.server.api.so.ISharedObject;

import com.paperworld.multiplayer.objects.Avatar;
import com.paperworld.multiplayer.player.Player;

public interface IConnector {

	public int incrementTime();
	
	public int getTime();
	
	public HashMap<String, Avatar> getAvatars();
	
	public HashMap<String, Player> getPlayers();
	
	public ISharedObject getSharedObject(String name, boolean persistent);
}
