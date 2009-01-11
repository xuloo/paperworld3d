package com.paperworld.multiplayer.objects;

import com.brainfarm.java.steering.Kinematic;

import ape.AbstractParticle;

public class PhysicsEnabledAvatar extends FixedUpdateRateAvatar {

	protected AbstractParticle physicsObject;
	
	public PhysicsEnabledAvatar() {
		
	}
	
	public PhysicsEnabledAvatar(Kinematic kinematic) {
		super(kinematic);
	}
}
