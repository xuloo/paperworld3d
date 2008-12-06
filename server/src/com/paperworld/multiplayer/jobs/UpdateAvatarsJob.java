package com.paperworld.multiplayer.jobs;

import java.util.HashMap;

import org.red5.server.api.scheduling.ISchedulingService;

import com.paperworld.multiplayer.connectors.IConnector;
import com.paperworld.multiplayer.objects.Avatar;

public class UpdateAvatarsJob extends AbstractUpdateJob {

	public UpdateAvatarsJob(IConnector connector) {
		super(connector);
	}

	@Override
	public void execute(ISchedulingService service)
			throws CloneNotSupportedException {

		int time = connector.incrementTime();

		HashMap<String, Avatar> avatars = connector.getAvatars();

		for (String key : avatars.keySet()) {
			avatars.get(key).update(time);
		}

	}

}
