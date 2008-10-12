package com.paperworld.multiplayer.jobs;

import org.red5.server.api.scheduling.IScheduledJob;
import org.red5.server.api.scheduling.ISchedulingService;

import com.paperworld.multiplayer.connectors.IConnector;

public abstract class AbstractUpdateJob implements IScheduledJob {

	protected IConnector connector;
	
	public AbstractUpdateJob(IConnector connector) {
		this.connector = connector;
	}
	
	@Override
	public void execute(ISchedulingService arg0)
			throws CloneNotSupportedException {

	}

}
