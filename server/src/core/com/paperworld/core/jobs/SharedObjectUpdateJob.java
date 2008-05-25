package com.paperworld.core.jobs;

import org.red5.server.api.scheduling.IScheduledJob;
import org.red5.server.api.scheduling.ISchedulingService;
import org.red5.server.api.so.ISharedObject;

import com.paperworld.core.avatar.Avatar;
import com.paperworld.core.player.Player;
import com.paperworld.scenes.RemoteScene;

public class SharedObjectUpdateJob implements IScheduledJob {
	
	private RemoteScene remoteScene;
	
	public SharedObjectUpdateJob(RemoteScene remoteScene) {
		this.remoteScene = remoteScene;
	}
	
	public void execute(ISchedulingService arg0)
			throws CloneNotSupportedException {
		try {
			ISharedObject so = remoteScene.getSO();
			
			so.beginUpdate();
			
			for (Player player : remoteScene.getPlayers()) {
				Avatar avatar = player.avatar;
				so.setAttribute(avatar.id, avatar.getAvatarData());
			}

			so.endUpdate();
		} catch (NullPointerException e) {
			
		}

	}

}
