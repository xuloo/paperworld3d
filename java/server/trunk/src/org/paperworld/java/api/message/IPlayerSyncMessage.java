package org.paperworld.java.api.message;

import org.paperworld.java.api.IInput;

/**
 * A Synchronisation message sent FROM the player TO the server.
 * 
 * The message from the player only contains input and time. There's 
 * no state sent in this direction.
 * 
 * @author Trevor
 *
 */
public interface IPlayerSyncMessage extends IMessage {

	public String getObjectId();
	public void setObjectId(String objectId);
	
	public IInput getInput();	
	public void setInput(IInput input);
	
	public int getTime();	
	public void setTime(int time);
}
