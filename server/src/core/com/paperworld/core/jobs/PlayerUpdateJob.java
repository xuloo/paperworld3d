package com.paperworld.core.jobs;

import org.red5.server.api.scheduling.IScheduledJob;
import org.red5.server.api.scheduling.ISchedulingService;

import com.paperworld.core.player.Player;
import com.paperworld.scenes.RemoteScene;

public class PlayerUpdateJob implements IScheduledJob {

	private RemoteScene scene;
	
	public PlayerUpdateJob(RemoteScene scene) {
		this.scene = scene;
		//System.out.println("player update job created");
	}
	
	public void execute(ISchedulingService arg0)
			throws CloneNotSupportedException {
		//System.out.println("updating " + scene.getPlayers().size() + " Players " + this);
		for (Player player : scene.getPlayers()) {
			player.update();
		}

	}

}
