package com.paperworld.java.api;

import org.red5.server.api.IConnection;

import com.paperworld.java.api.message.IMessage;

public interface IPlayer {

	public String getId();
	
	public IInput getInput();
	
	public String getName();
	
	public void setName(String name);
	
	public IAvatar getAvatar();
	
	public void setAvatar(IAvatar avatar);
	
	public IConnection getConnection();
	
	public void setConnection(IConnection connection);
	
	public boolean sendMessage(IMessage message);
}
