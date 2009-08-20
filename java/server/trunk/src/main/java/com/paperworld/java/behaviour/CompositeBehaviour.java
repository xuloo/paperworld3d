package com.paperworld.java.behaviour;

import java.util.ArrayList;

import com.paperworld.java.api.IBehaviour;
import com.paperworld.java.api.IInput;
import com.paperworld.java.api.IState;
import com.paperworld.java.state.BasicState;

public class CompositeBehaviour implements IBehaviour {

	private ArrayList<IBehaviour> behaviours = new ArrayList<IBehaviour>();
	
	public CompositeBehaviour() {
		
	}
	
	public void addBehaviour(IBehaviour behaviour) {
		behaviours.add(behaviour);
	}
	
	@Override
	public void update(int time, IInput input, BasicState state) {
		for (IBehaviour behaviour : behaviours) {
			behaviour.update(time, input, state);
		}
	}

}
