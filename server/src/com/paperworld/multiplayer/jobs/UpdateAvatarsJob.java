package com.paperworld.multiplayer.jobs;

import java.util.HashMap;

import org.red5.server.api.scheduling.ISchedulingService;

import com.paperworld.multiplayer.connectors.IConnector;
import com.paperworld.multiplayer.player.Player;

public class UpdateAvatarsJob extends AbstractUpdateJob {

	public UpdateAvatarsJob(IConnector connector) {
		super(connector);
	}

	@Override
	public void execute(ISchedulingService service)
			throws CloneNotSupportedException {

		int time = connector.incrementTime();

		HashMap<String, Player> players = connector.getPlayers();

		for (String key : players.keySet()) {
			//System.out.println("updating " + players.get(key).getAvatar());
			players.get(key).getAvatar().update(time);
		}

	}

}
