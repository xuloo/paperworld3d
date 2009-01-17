package com.paperworld.java.api;

import com.actionengine.api.IInput;
import com.paperworld.multiplayer.data.AvatarData;
import com.paperworld.multiplayer.data.SyncData;

public interface ISynchronisedScene {
	
	public AvatarData addPlayer(String id);
	
	public void setAvatar(ISynchronisedAvatar avatar);
	
	public void setAvatar(String key);
	
	public int getAvatar(String key);
	
	public SyncData receiveInput(String uid, IInput input);
}
