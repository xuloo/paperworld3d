package com.paperworld.java.api;

import com.paperworld.multiplayer.data.SyncData;
import com.paperworld.multiplayer.data.TimedInput;

public interface IScene {
	
	public SyncData addPlayer(String id);
	
	public SyncData receiveInput(String uid, TimedInput input);
}
