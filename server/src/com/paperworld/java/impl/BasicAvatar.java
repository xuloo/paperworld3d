package com.paperworld.java.impl;

import org.red5.server.api.IConnection;

import com.paperworld.java.api.IAvatar;
import com.paperworld.java.api.IBehaviour;
import com.paperworld.java.api.IInput;
import com.paperworld.java.api.IState;

public class BasicAvatar implements IAvatar {
	
	protected IInput input;
	
	protected IState state;
	
	protected IBehaviour behaviour;
	
	protected IConnection connection;
	
	public BasicAvatar() {
		this(new BasicInput(), new BasicState());
	}
	
	public BasicAvatar(IInput input, IState state) {
		this.input = input;
		this.state = state;
	}
	
	@Override
	public void updateUserInput(int time, IInput input) {
		if (time > state.getTime()) {
			this.input = input;
		}
	}

	@Override
	public void setBehaviour(IBehaviour behaviour) {
		this.behaviour = behaviour;
	}

	@Override
	public IConnection getConnection() {
		return connection;
	}

	@Override
	public void setConnection(IConnection connection) {
		this.connection = connection;
	}
	
	public IState getState() {
		return state;
	}
}
