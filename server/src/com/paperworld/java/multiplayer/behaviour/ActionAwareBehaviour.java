package com.paperworld.java.multiplayer.behaviour;

import com.paperworld.java.action.Action;
import com.paperworld.java.api.ISynchronisedAvatar;
import com.paperworld.java.api.IBehaviour;

public class ActionAwareBehaviour implements IBehaviour {
	
	protected Action action;
	
	public Action getAction() {
		return action;
	}
	
	public void setAction(Action action) {
		this.action = action;
	}

	@Override
	public void apply(ISynchronisedAvatar avatar) {
		action.act();		
	}

}
