package com.paperworld.core.avatar.behaviour;

import com.paperworld.core.avatar.Avatar;

/**
 * The steering behaviour is the base class for all dynamic steering behaviours.
 */
abstract public class AbstractSteeringBehaviour {
	/**
	 * The character who is moving.
	 */
	protected Avatar character;

	public void setCharacter(Avatar c) {
		character = c;
	}

	/**
	 * Works out the desired steering and writes it into the given steering
	 * output structure.
	 */
	abstract public void run();

}
