package com.paperworld.java.api.message;

import com.paperworld.java.api.IInput;
import com.paperworld.java.api.IState;
import com.paperworld.java.impl.BasicState;

public interface ISynchroniseCreateMessage {

	public String getPlayerId();	
	public void setPlayerId(String playerId);
	
	public String getObjectId();
	public void setObjectId(String objectId);
	
	public IInput getInput();
	public void setInput(IInput input);
	
	public BasicState getState();
	public void setState(BasicState state);
}
