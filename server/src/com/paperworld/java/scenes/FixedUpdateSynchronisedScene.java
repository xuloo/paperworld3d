package com.paperworld.java.scenes;

import java.util.Timer;
import java.util.TimerTask;

import org.red5.server.api.so.ISharedObject;

import com.actionengine.api.IInput;
import com.paperworld.java.api.ISynchronisedAvatar;
import com.paperworld.multiplayer.data.AvatarData;
import com.paperworld.multiplayer.data.SyncData;

public class FixedUpdateSynchronisedScene extends BasicSynchronisedScene {

	protected int behaviourUpdateRate;

	protected int clientUpdateRate;

	public int time = 0;

	protected Timer timer = new Timer("Timer", true);

	public FixedUpdateSynchronisedScene() {
	}

	@Override
	public void init() {
		super.init();

		timer.scheduleAtFixedRate(new UpdateAvatarsTask(), 0, 
				1000 / behaviourUpdateRate);
		
		timer.scheduleAtFixedRate(new UpdateSharedObjectTask(), 0,
				1000 / clientUpdateRate);
	}
	
	public SyncData receiveInput(String uid, IInput input) {
		ISynchronisedAvatar avatar = players.get(uid).getAvatar();

		avatar.setUserInput(input);
		
		return new SyncData(getTime(), avatar.getAvatarData());
	}
	
	@Override
	public AvatarData addPlayer(String id) {
		ISynchronisedAvatar avatar = players.get(id).getAvatar();

		avatar.setId(id);
		avatar.setKey("avatar");
		setAvatar(avatar);
		
		//return new SyncData(time, 0, avatar.getInput(), avatar.getState());
		return new AvatarData(avatar);
	}
	
	public int incrementTime() {
		return time++;
	}

	public int getTime() {
		return time;
	}
	
	public void setBehaviourUpdateRate(int behaviourUpdateRate) {
		this.behaviourUpdateRate = behaviourUpdateRate;
	}
	
	public void setClientUpdateRate(int clientUpdateRate) {
		this.clientUpdateRate = clientUpdateRate;
	}

	protected class UpdateAvatarsTask extends TimerTask {

		@Override
		public void run() {
			time++;

			for (String key : avatars.keySet()) {
				avatars.get(key).updateBehaviour();
			}
		}		
	}
	
	protected class UpdateSharedObjectTask extends TimerTask {

		@Override
		public void run() {
			ISharedObject so = getSharedObject();

			so.beginUpdate();

			for (String key : avatars.keySet()) {
				ISynchronisedAvatar avatar = avatars.get(key);
				avatar.updateSharedObject(so);
				//so.setAttribute(key, new SyncData(time, avatar.getInput(), avatar.getState()));
			}

			so.endUpdate();			
		}
		
	}
}
