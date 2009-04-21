package com.paperworld.java.impl;

import org.red5.server.api.IConnection;

import com.paperworld.java.api.IAvatar;
import com.paperworld.java.api.IInput;
import com.paperworld.java.api.IPlayer;

public class BasicPlayer implements IPlayer {

	protected IAvatar avatar;
	
	protected IInput input;
	
	protected String name;
	
	protected IConnection connection;
	
	public BasicPlayer(String name, IConnection connection) {
		this(name);
		setConnection(connection);
	}
	
	public BasicPlayer(String name) {
		setName(name);
	}
	
	@Override
	public IAvatar getAvatar() {
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

	@Override
	public IInput getInput() {
		return input;
	}
}
