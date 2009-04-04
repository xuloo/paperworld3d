package com.paperworld.java.api;

import com.paperworld.java.multiplayer.data.AvatarData;
import com.paperworld.java.multiplayer.data.SyncData;


public interface ISynchronisedScene {
	
	public AvatarData addPlayer(String id);
	
	public void setAvatar(ISynchronisedAvatar avatar);
	
	public void setAvatar(String key);
	
	//public int getAvatar(String key);
	
	public int getTime();
	
	public SyncData receiveInput(String uid, IInput input);
}
