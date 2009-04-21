package com.paperworld.java.api.message;

import com.paperworld.java.api.IState;

/**
 * This is a synchronisation message sent FROM the server TO the player.
 * 
 * This message contains a state object that the player can sync to.
 * 
 * @author Trevor
 *
 */
public interface IServerSyncMessage extends IPlayerSyncMessage {
	
	public IState getState();
	
	public void setState(IState state);
}
