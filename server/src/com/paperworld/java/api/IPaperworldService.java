package com.paperworld.java.api;

import java.util.Map;

import org.red5.server.adapter.IApplication;
import org.red5.server.adapter.MultiThreadedApplicationAdapter;
import org.red5.server.api.so.ISharedObject;

import com.paperworld.java.api.message.IMessage;
import com.paperworld.java.util.AbstractProcessor;

public interface IPaperworldService extends IApplication {

	public void setApplication(MultiThreadedApplicationAdapter application);
	
	public ISharedObject getSharedObject(String name, boolean persistent);
	
	public String getNextId(String id);
	
	public Object receiveMessage(IMessage message);
	
	public Map<String, IPlayer> getPlayers();
	
	public void addMessageProcessor(AbstractProcessor processor);
}
