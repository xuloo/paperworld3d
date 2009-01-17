package com.paperworld.java.api;

import org.red5.server.api.so.ISharedObject;

import com.actionengine.api.IInput;
import com.brainfarm.java.data.State;
import com.paperworld.multiplayer.data.AvatarData;
import com.paperworld.multiplayer.player.PlayerContext;

public interface ISynchronisedAvatar {

	public void setPlayerContext(PlayerContext context);

	public void updateBehaviour();

	public void setUserInput(IInput input);

	// public void updateInput(TimedInput input);

	public String getId();

	public void setId(String id);

	public String getKey();

	public void setKey(String key);

	public State getState();

	public IInput getInput();

	public int getTime();

	public AvatarData getAvatarData();

	public void updateSharedObject(ISharedObject so);

	public void setScene(ISynchronisedScene scene);

	public ISynchronisedScene getScene();

	// public Kinematic getKinematic();

	public void destroy();
}
