package com.paperworld.examples.fps;

import com.actionengine.java.data.Input;
import com.brainfarm.java.data.State;
import com.brainfarm.java.steering.AbstractSteeringBehaviour;
import com.brainfarm.java.steering.SteeringOutput;

public class ForwardBehaviour extends AbstractSteeringBehaviour {

	protected double distance;
	
	public void setDistance(double distance) {
		this.distance = distance;
	}
	
	@Override
	public void getSteering(SteeringOutput arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public void getSteering(SteeringOutput arg0, Input arg1) {
		// TODO Auto-generated method stub

	}

	@Override
	public void getSteering(State state, Input input) {
		
	}

}
