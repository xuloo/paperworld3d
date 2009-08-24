/*
 * Part of the Artificial Intelligence for Games system.
 *
 * Copyright (c) Ian Millington 2003-2006. All Rights Reserved.
 *
 * This software is distributed under licence. Use of this software
 * implies agreement with all terms and conditions of the accompanying
 * software licence.
 * 
 * Java port - Trevor Burton [worldofpaper@googlemail.com]
 */
package org.paperworld.java.ai.steering.behaviour;

import org.paperworld.java.ai.steering.AbstractSteeringBehaviour;
import org.paperworld.java.ai.steering.SteeringOutput;
import org.paperworld.java.api.IInput;

import com.jme.math.Vector3f;

/**
 * The seek steering behaviour takes a target and aims right for it with maximum
 * acceleration.
 */
public class Seek extends AbstractSteeringBehaviour
{
	/**
	 * The target may be any vector (i.e. it might be something that has no
	 * orientation, such as a point in space).
	 */
	public Vector3f	target;
	
	/**
	 * The maximum acceleration that can be used to reach the target.
	 */
	public float maxAcceleration;
	
	/**
	 * Works out the desired steering and writes it into the given steering
	 * output structure.
	 */
	public void getSteering(SteeringOutput output)
	{
		// First work out the direction
		output.linear = target;
		output.linear.subtract(character.position);
		
		// If there is no direction, do nothing
		if (output.linear.lengthSquared() > 0)
		{
			output.linear.normalize();
			output.linear.mult(maxAcceleration);
		}
	}

	@Override
	public void getSteering(SteeringOutput output, IInput input) {
		// TODO Auto-generated method stub
		
	}
}