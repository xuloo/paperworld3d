package com.paperworld.java.api.message;

import com.paperworld.java.api.IInput;
import com.paperworld.java.api.IState;

public interface ISynchroniseCreateMessage {

	public String getPlayerId();	
	public void setPlayerId(String playerId);
	
	public String getObjectId();
	public void setObjectId(String objectId);
	
	public IInput getInput();
	public void setInput(IInput input);
	
	public IState getState();
	public void setState(IState state);
}
