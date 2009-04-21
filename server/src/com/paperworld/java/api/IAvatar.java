package com.paperworld.java.api;

import org.red5.server.api.IConnection;

public interface IAvatar {

	public void setBehaviour(IBehaviour behaviour);
	
	public void updateUserInput(int time, IInput input);
	
	public void setConnection(IConnection connection);
	
	public IConnection getConnection();
	
	public IState getState();
}
