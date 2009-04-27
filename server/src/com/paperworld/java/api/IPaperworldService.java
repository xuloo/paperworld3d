package com.paperworld.java.api;

import java.util.Map;

import org.red5.server.api.so.ISharedObject;

import com.paperworld.java.api.message.IMessage;
import com.paperworld.java.api.message.ISynchroniseCreateMessage;
import com.paperworld.java.util.AbstractProcessor;

public interface IPaperworldService extends IService {
	
	public ISharedObject getSharedObject(String name, boolean persistent);
	
	public String getNextId(String id);
	
	public Object receiveMessage(IMessage message);
	
	public Map<String, IPlayer> getPlayers();
	
	public void addMessageProcessor(AbstractProcessor processor);
	
	public void processSynchroniseCreateMessage(ISynchroniseCreateMessage message);
	
	public IAvatar getAvatarForPlayer(IPlayer player);
	
	public IAvatar getAvatar(String objectId);
}
