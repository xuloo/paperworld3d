package com.paperworld.java.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.red5.server.api.IConnection;
import org.red5.server.api.service.ServiceUtils;

import com.paperworld.java.api.IAvatar;
import com.paperworld.java.api.IInput;
import com.paperworld.java.api.IPaperworldService;
import com.paperworld.java.api.IPlayer;
import com.paperworld.java.api.message.IMessage;

public class BasicPlayer implements IPlayer {

	protected List<IAvatar> avatars = Collections.synchronizedList(new ArrayList<IAvatar>());
	
	protected IAvatar scopeObject;
	
	protected IInput input;
	
	protected String name;
	
	protected IConnection connection;
	
	protected IPaperworldService service;
	
	public BasicPlayer(IPaperworldService service, String name, IConnection connection) {
		this(name, connection);
		this.service = service;
	}
	
	public BasicPlayer(String name, IConnection connection) {
		this(name);
		setConnection(connection);
	}
	
	public BasicPlayer(String name) {
		setName(name);
		
		input = new BasicInput();
		
		scopeObject = service.getFactory().getAvatar(this);
	}
	
	public boolean sendMessage(IMessage message) {
		return ServiceUtils.invokeOnConnection(getConnection(),
				"receiveMessage", new Object[] { message });
	}
	
	@Override
	public IAvatar getScopeObject() {	
		return scopeObject;
	}
	
	@Override
	public void setScopeObject(IAvatar scopeObject) {
		this.scopeObject = scopeObject;
		
		if (!avatars.contains(scopeObject)) {
			avatars.add(scopeObject);
		}
	}
	
	@Override
	public void addAvatar(IAvatar avatar) {
		avatars.add(avatar);		
	}
	
	@Override
	public void removeAvatar(IAvatar avatar) {
		avatars.remove(avatar);	
		if (avatar.equals(scopeObject)) {
			scopeObject = null;
		}
	}

	@Override
	public void performScopeQuery(List<IAvatar> avatars) {
		
	}	

	@Override
	public String getName() {		
		return name;
	}	

	@Override
	public void setName(String name) {
		this.name = name;
	}
	
	@Override
	public IConnection getConnection() {
		return connection;
	}
	
	@Override
	public void setConnection(IConnection connection) {
		this.connection = connection;
	}
	
	public String getId() {
		return getConnection().getClient().getId();
	}
}
