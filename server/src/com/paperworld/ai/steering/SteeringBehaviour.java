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
package com.paperworld.ai.steering;


/**
 * The steering behaviour is the base class for all dynamic
 * steering behaviours.
 */
abstract public class SteeringBehaviour {
	/**
     * The character who is moving.
     */
    public Kinematic character;

    /**
     * Works out the desired steering and writes it into the given
     * steering output structure.
     */
    abstract public void getSteering(SteeringOutput output);
}
