package com.paperworld.java.api;

import com.paperworld.java.api.IInput;

public interface IInputHandler {

	public void handleInput(ISynchronisedAvatar avatar, IInput input);
	
	public boolean addBehaviour(IBehaviour behaviour);
}
