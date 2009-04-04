package com.paperworld.java.scenes;

import org.red5.server.adapter.ApplicationAdapter;
import org.red5.server.adapter.IApplication;
import org.red5.server.api.IClient;
import org.red5.server.api.IConnection;
import org.red5.server.api.IScope;

import com.paperworld.java.api.IAvatarFactory;
import com.paperworld.java.api.IInput;
import com.paperworld.java.api.IService;
import com.paperworld.java.api.ISynchronisedAvatar;
import com.paperworld.java.api.ISynchronisedScene;
import com.paperworld.java.multiplayer.data.AvatarData;
import com.paperworld.java.multiplayer.data.SyncData;

public class AbstractSynchronisedScene implements ISynchronisedScene,
		IApplication, IService {
	
	protected int time;

	protected ApplicationAdapter application;

	protected IAvatarFactory avatarFactory;

	@Override
	public void setApplication(ApplicationAdapter application) {
		this.application = application;
		application.addListener(this);
	}

	public void setAvatarFactory(IAvatarFactory avatarFactory) {
		this.avatarFactory = avatarFactory;
	}

	public int getTime() {
		return 0;
	}
	
	@Override
	public void setAvatar(ISynchronisedAvatar avatar) {

	}

	@Override
	public void setAvatar(String key) {
		ISynchronisedAvatar avatar = avatarFactory.getAvatar(key);
		System.out.println("avatar being injected: " + avatar);
		setAvatar(avatar);
	}

	/*public int getAvatar(String key) {
		return 0;
	}*/

	@Override
	public AvatarData addPlayer(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public SyncData receiveInput(String uid, IInput input) {
		// TODO Auto-generated method stub
		return null;
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
