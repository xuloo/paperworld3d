package com.paperworld.java.inputhandlers;

import java.util.ArrayList;
import java.util.List;

import com.actionengine.java.data.Input;
import com.paperworld.java.api.IAvatar;
import com.paperworld.java.api.IBehaviour;
import com.paperworld.java.api.IInputHandler;

public class InputHandler implements IInputHandler {
	
	protected List<IBehaviour> behaviours;
	
	public InputHandler() {
		behaviours = new ArrayList<IBehaviour>();
	}
	
	@Override
	public void handleInput(IAvatar avatar, Input input) {
		for (IBehaviour behaviour : behaviours) {
			behaviour.apply(avatar);
		}
	}
	
	public boolean addBehaviour(IBehaviour behaviour) {
		if (!behaviours.contains(behaviour)) {
			behaviours.add(behaviour);
			return true;
		}
		
		return false;
	}
	
	public void setBehaviour(IBehaviour behaviour) {
		addBehaviour(behaviour);
	}
	
	public void setBehaviours(List<IBehaviour> behaviours) {
		System.out.println("setting behaviours " + behaviours);
		this.behaviours = behaviours;
	}
}
