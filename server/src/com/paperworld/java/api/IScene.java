package com.paperworld.java.api;

import org.red5.server.api.IContext;

import com.paperworld.multiplayer.data.SyncData;
import com.paperworld.multiplayer.data.TimedInput;

public interface IScene {
	
	public SyncData addPlayer(String id);
	
	public void setAvatar(IAvatar avatar);
	
	public void setAvatar(String key);
	
	public SyncData receiveInput(String uid, TimedInput input);
}
