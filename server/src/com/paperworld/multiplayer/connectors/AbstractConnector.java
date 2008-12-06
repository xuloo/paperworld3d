package com.paperworld.multiplayer.connectors;

import java.util.HashMap;

import org.red5.server.adapter.IApplication;
import org.red5.server.adapter.MultiThreadedApplicationAdapter;
import org.red5.server.api.IClient;
import org.red5.server.api.IConnection;
import org.red5.server.api.IScope;
import org.red5.server.api.scheduling.IScheduledJob;
import org.red5.server.api.scheduling.ISchedulingService;
import org.red5.server.api.so.ISharedObject;

import com.paperworld.multiplayer.objects.Avatar;
import com.paperworld.multiplayer.player.Player;

public class AbstractConnector implements IApplication, IConnector, IService,
		IScheduledJob {

	protected HashMap<String, Player> players;

	protected HashMap<String, Avatar> avatars;

	protected IScope scope;

	protected MultiThreadedApplicationAdapter application;

	protected int frameRate;
	
	

	public AbstractConnector() {
		players = new HashMap<String, Player>();
		avatars = new HashMap<String, Avatar>();
	}

	public void setApplication(MultiThreadedApplicationAdapter application) {
		this.application = application;
		application.addListener(this);
	}

	public void setFrameRate(int frameRate) {
		this.frameRate = frameRate;
	}

	protected String createScheduledJob(int interval, IScheduledJob job) {
		return application.addScheduledJob(interval, job);
	}

	@Override
	public HashMap<String, Player> getPlayers() {
		return players;
	}

	@Override
	public HashMap<String, Avatar> getAvatars() {
		return avatars;
	}

	@Override
	public ISharedObject getSharedObject(String name, boolean persistent) {
		return null;
	}

	@Override
	public int incrementTime() {
		return 0;
	}

	@Override
	public int getTime() {
		return 0;
	}

	public void setAvatar(Avatar avatar) {
		avatars.put(avatar.getAvatarData().getRef(), avatar);
	}

	public void setAvatars(HashMap<String, Avatar> avatars) {
		this.avatars = avatars;
	}

	public void execute(ISchedulingService arg0)
			throws CloneNotSupportedException {
		// TODO Auto-generated method stub

	}

	@Override
	public boolean appConnect(IConnection arg0, Object[] arg1) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void appDisconnect(IConnection arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public boolean appJoin(IClient arg0, IScope arg1) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void appLeave(IClient arg0, IScope arg1) {
		// TODO Auto-generated method stub

	}

	@Override
	public boolean appStart(IScope arg0) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void appStop(IScope arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public boolean roomConnect(IConnection arg0, Object[] arg1) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void roomDisconnect(IConnection arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public boolean roomJoin(IClient arg0, IScope arg1) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void roomLeave(IClient arg0, IScope arg1) {
		// TODO Auto-generated method stub

	}

	@Override
	public boolean roomStart(IScope arg0) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void roomStop(IScope arg0) {
		// TODO Auto-generated method stub

	}
}
