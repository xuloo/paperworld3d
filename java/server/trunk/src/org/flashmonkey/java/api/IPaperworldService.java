package org.paperworld.java.api;

import java.util.Map;

import org.paperworld.java.api.message.IMessage;
import org.paperworld.java.util.AbstractProcessor;
import org.red5.server.api.so.ISharedObject;

public interface IPaperworldService extends IService {
	
	public ISharedObject getSharedObject(String name, boolean persistent);
	
	public String getNextId(String id);
	
	public Object receiveMessage(IMessage message);
	
	public Map<String, IPlayer> getPlayers();
	
	public void addMessageProcessor(AbstractProcessor processor);
	
	public IPlayer getPlayer(String id);
	
	public IAvatarFactory getFactory();
	public void setAvatarFactory(IAvatarFactory factory);
	
	public IAvatar getAvatar(String objectId);
	
	public void registerAvatar(IAvatar avatar);
}
