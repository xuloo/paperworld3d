package com.paperworld.java.api;

import org.red5.server.api.so.ISharedObject;

import com.actionengine.java.data.Input;
import com.brainfarm.java.data.State;
import com.brainfarm.java.steering.Kinematic;
import com.paperworld.multiplayer.data.AvatarData;
import com.paperworld.multiplayer.data.TimedInput;
import com.paperworld.multiplayer.player.PlayerContext;

public interface IAvatar {
	
	public void setPlayerContext(PlayerContext context);
	
	public void updateBehaviour();
	
	public void setUserInput(int time, Input input);

	//public void updateInput(TimedInput input);
	
	public State getState();
	
	public Input getInput();
	
	public int getTime();
	
	public AvatarData getAvatarData();
	
	public void updateSharedObject(ISharedObject so);
	
	public void setScene(IScene scene);
	
	public IScene getScene();
	
	public Kinematic getKinematic();
	
	public void destroy();
}