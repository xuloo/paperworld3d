package com.paperworld.core.jobs;

import java.util.ArrayList;

import org.red5.server.api.scheduling.IScheduledJob;
import org.red5.server.api.scheduling.ISchedulingService;

import com.paperworld.core.player.Player;

public class PlayerUpdateJob implements IScheduledJob {

	private ArrayList<Player> players;
	
	public PlayerUpdateJob(ArrayList<Player> players) {
		this.players = players;
	}
	
	public void execute(ISchedulingService arg0)
			throws CloneNotSupportedException {
		for (Player player : players) {
			player.update();
		}

	}

}
