package org.flashmonkey.java.behaviour;

import java.util.ArrayList;

import org.flashmonkey.java.api.IBehaviour;
import org.flashmonkey.java.api.IInput;
import org.flashmonkey.java.core.objects.BasicState;

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
