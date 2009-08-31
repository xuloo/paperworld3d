package org.flashmonkey.java.connection.red5.service.api;

import java.util.Map;

import org.flashmonkey.java.avatar.api.IAvatar;
import org.flashmonkey.java.avatar.factory.api.IAvatarFactory;
import org.flashmonkey.java.message.api.IMessage;
import org.flashmonkey.java.player.api.IPlayer;
import org.flashmonkey.java.util.AbstractMessageProcessor;
import org.red5.server.api.so.ISharedObject;

public interface IPaperworldService extends IService {
	
	public ISharedObject getSharedObject(String name, boolean persistent);
	
	public String getNextId(String id);
	
	public Object receiveMessage(IMessage message);
	
	public Map<String, IPlayer> getPlayers();
	
	public void addMessageProcessor(AbstractMessageProcessor processor);
	
	public IPlayer getPlayer(String id);
	
	//public IAvatarFactory getAvatarFactory();
	public void setAvatarFactory(IAvatarFactory factory);
	
	public IAvatar getAvatar(String objectId);
	
	public void registerAvatar(IAvatar avatar);
}