package com.paperworld.multiplayer.jobs;

import java.util.HashMap;

import org.red5.server.api.scheduling.ISchedulingService;
import org.red5.server.api.so.ISharedObject;

import com.paperworld.multiplayer.connectors.IConnector;
import com.paperworld.multiplayer.data.Input;
import com.paperworld.multiplayer.data.State;
import com.paperworld.multiplayer.data.SyncData;
import com.paperworld.multiplayer.objects.Avatar;
import com.paperworld.multiplayer.player.Player;
import com.paperworld.multiplayer.player.PlayerContext;

public class UpdateSharedObjectJob extends AbstractUpdateJob {
		
	public UpdateSharedObjectJob(IConnector connector) {
		super(connector);
	}
	
	@Override
	public void execute(ISchedulingService arg0)
			throws CloneNotSupportedException {
		
		HashMap<String, Player> players = connector.getPlayers();
		ISharedObject so = connector.getSharedObject("avatars", false);
		
		so.beginUpdate();
		
		for (String key : players.keySet()) {
			Player player = players.get(key);
			PlayerContext playerContext = player.getContext();
			String id = playerContext.getId();
			Avatar avatar = player.getAvatar();
			int time = connector.getTime();
			Input input = avatar.input;
			State state = avatar.getState();

			so.setAttribute(id, new SyncData(time, input, state));
		}
		
		so.endUpdate();

	}

}
