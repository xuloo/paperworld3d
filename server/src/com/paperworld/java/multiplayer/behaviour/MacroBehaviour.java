package com.paperworld.java.multiplayer.behaviour;

import java.util.ArrayList;

import com.paperworld.java.ai.steering.AbstractSteeringBehaviour;
import com.paperworld.java.ai.steering.SteeringOutput;
import com.paperworld.java.data.Input;
import com.paperworld.java.multiplayer.data.State;

public class MacroBehaviour extends AbstractSteeringBehaviour {

	protected ArrayList<AbstractSteeringBehaviour> behaviours;

	public MacroBehaviour() {
		setBehaviours(new ArrayList<AbstractSteeringBehaviour>());
	}

	public MacroBehaviour(ArrayList<AbstractSteeringBehaviour> behaviours) {
		setBehaviours(behaviours);
	}

	public void setBehaviours(ArrayList<AbstractSteeringBehaviour> behaviours) {
		this.behaviours = behaviours;
	}

	public void setBehaviour(AbstractSteeringBehaviour behaviour) {
		behaviours.add(behaviour);
	}

	@Override
	public void getSteering(SteeringOutput output) {
		for (AbstractSteeringBehaviour behaviour : behaviours) {
			behaviour.getSteering(output);
		}
	}

	@Override
	public void getSteering(SteeringOutput output, Input input) {
		for (AbstractSteeringBehaviour behaviour : behaviours) {
			behaviour.getSteering(output, input);
		}
	}

	@Override
	public void getSteering(State state, Input input) {
		for (AbstractSteeringBehaviour behaviour : behaviours) {
			behaviour.getSteering(state, input);
		}
	}

}
