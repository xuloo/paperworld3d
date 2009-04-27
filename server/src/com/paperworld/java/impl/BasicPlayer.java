package com.paperworld.java.impl;

import org.red5.server.api.IConnection;
import org.red5.server.api.service.ServiceUtils;

import com.paperworld.java.api.IAvatar;
import com.paperworld.java.api.IInput;
import com.paperworld.java.api.IPaperworldService;
import com.paperworld.java.api.IPlayer;
import com.paperworld.java.api.message.IMessage;

public class BasicPlayer implements IPlayer {

	protected IAvatar avatar;
	
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
	}
	
	public boolean sendMessage(IMessage message) {
		return ServiceUtils.invokeOnConnection(getConnection(),
				"receiveMessage", new Object[] { message });
	}
	
	@Override
	public IAvatar getAvatar() {		
		if (avatar == null) {
			avatar = service.getAvatarForPlayer(this);
		}
		
		return avatar;
	}

	@Override
	public String getName() {		
		return name;
	}

	@Override
	public void setAvatar(IAvatar avatar) {
		this.avatar = avatar;
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
