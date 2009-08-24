package org.flashmonkey.java.api;

import java.util.List;

import org.flashmonkey.java.api.message.IMessage;
import org.red5.server.api.IConnection;

public interface IPlayer {

	public String getId();
	
	public String getName();
	
	public void setName(String name);
	
	public void addAvatar(IAvatar avatar);
	
	public void removeAvatar(IAvatar avatar);
	
	public IAvatar getScopeObject();	
	public void setScopeObject(IAvatar avatar);
	
	public void performScopeQuery(List<IAvatar> avatars);
	
	public IConnection getConnection();
	
	public void setConnection(IConnection connection);
	
	public boolean sendMessage(IMessage message);
}
