package org.paperworld.java.api.message;

import org.paperworld.java.api.IInput;
import org.paperworld.java.state.BasicState;

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
