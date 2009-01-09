package com.paperworld.java.scenes;

import java.util.Timer;
import java.util.TimerTask;

import org.red5.server.api.so.ISharedObject;

import com.paperworld.java.api.IAvatar;
import com.paperworld.multiplayer.data.SyncData;

public class FixedUpdateSceneAdapter extends SynchronisedSceneAdapter {

	protected int behaviourUpdateRate;

	protected int clientUpdateRate;

	public int time = 0;

	protected Timer timer = new Timer("Timer", true);

	public FixedUpdateSceneAdapter() {
	}

	@Override
	public void init() {
		super.init();

		timer.scheduleAtFixedRate(new UpdateAvatarsTask(), 0, 
				1000 / behaviourUpdateRate);
		
		timer.scheduleAtFixedRate(new UpdateSharedObjectTask(), 0,
				1000 / clientUpdateRate);
	}
	
	@Override
	public SyncData addPlayer(String id) {
		IAvatar avatar = players.get(id).getAvatar();

		avatars.put(id, avatar);
		
		return new SyncData(time, 0, avatar.getInput(), avatar.getState());
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
				IAvatar avatar = avatars.get(key);
				
				so.setAttribute(key, new SyncData(time, avatar.getInput(), avatar.getState()));
			}

			so.endUpdate();			
		}
		
	}
}
