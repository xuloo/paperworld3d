package com.paperworld.java.api;

import com.actionengine.java.data.Input;

public interface IInputHandler {

	public void handleInput(IAvatar avatar, Input input);
	
	public boolean addBehaviour(IBehaviour behaviour);
}
