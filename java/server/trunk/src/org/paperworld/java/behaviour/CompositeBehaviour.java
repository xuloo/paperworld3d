package org.paperworld.java.behaviour;

import java.util.ArrayList;

import org.paperworld.java.api.IBehaviour;
import org.paperworld.java.api.IInput;
import org.paperworld.java.core.objects.BasicState;

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
