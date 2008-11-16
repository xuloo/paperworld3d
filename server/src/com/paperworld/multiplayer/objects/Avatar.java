/* --------------------------------------------------------------------------------------
 * PaperWorld3D - building better worlds
 * --------------------------------------------------------------------------------------
 * Real-Time Multi-User Application Framework for the Flash Platform.
 * --------------------------------------------------------------------------------------
 * Copyright (C) 2008 Trevor Burton [worldofpaper@googlemail.com]
 * --------------------------------------------------------------------------------------
 * 
 * This library is free software; you can redistribute it and/or modify it under the 
 * terms of the GNU Lesser General Public License as published by the Free Software 
 * Foundation; either version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT ANY 
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A 
 * PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License along with 
 * this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, 
 * Suite 330, Boston, MA 02111-1307 USA 
 * 
 * -------------------------------------------------------------------------------------- */
package com.paperworld.multiplayer.objects;

import org.red5.server.api.so.ISharedObject;

import com.actionengine.java.data.Input;
import com.actionengine.java.util.collections.CircularBuffer;
import com.brainfarm.java.steering.AbstractSteeringBehaviour;
import com.brainfarm.java.steering.Kinematic;
import com.brainfarm.java.steering.SteeringOutput;
import com.paperworld.multiplayer.data.AvatarData;
import com.paperworld.multiplayer.data.State;
import com.paperworld.multiplayer.data.SyncData;
import com.paperworld.multiplayer.data.TimedInput;
import com.paperworld.multiplayer.player.PlayerContext;

public class Avatar {

	protected Kinematic kinematic;

	/**
	 * The current Input state for this Kinematic.
	 */
	public Input input;

	public CircularBuffer<TimedInput> buffer;

	/**
	 * The current time for this Kinematic.
	 */
	public int time;

	public State state;

	public String ref;

	protected PlayerContext playerContext;
	
	protected SteeringOutput output = new SteeringOutput();

	/**
	 * The IBehaviour object that's used to interpret the Input for this
	 * Kinematic.
	 */
	public AbstractSteeringBehaviour behaviour;

	public Avatar() {
		initialise();
	}
	
	public Avatar(Kinematic kinematic) {
		this.kinematic = kinematic;

		initialise();
	}

	public void initialise() {
		buffer = new CircularBuffer<TimedInput>(TimedInput.class);
		input = new Input();
		state = new State();
	}

	/**
	 * Updates the Avatar's behaviour. Checks the Input buffer to see if we have
	 * a stored move for the time passed as an argument. If none exists
	 * (client's time stream is behind server) then use the last Input object
	 * received from the client.
	 * 
	 * @param time
	 */
	public void update(int time) {

		// Get rid of out of data moves.
		try {
			// if (buffer.oldest() != null) {
			while (buffer.oldest().time < time && !buffer.empty()) {
				buffer.remove();
			}
			// }
		} catch (Exception e) {

		}

		Input input = this.input;

		// Get the Move at the time required.
		/*
		 * TimedInput move = buffer.oldest(); // If there is a move at this time
		 * then use it's input. if (move == null) { input = this.input; } else { //
		 * Otherwise use the last recorded Input object. input = move.input; }
		 */

		// Update the behaviour.
		behaviour.getSteering(output);
		
		kinematic.velocity = output.linear;
		kinematic.position.add(output.linear);
		kinematic.orientation = output.angular;
	}

	public void update(TimedInput move) {
		buffer.add(move);

		this.input = move.input;
	}

	public void updateSharedObject(ISharedObject so) {

		so.setAttribute(playerContext.getId(), new SyncData(time, this.input,
				getState()));
	}

	public Kinematic getKinematic() {
		return kinematic;
	}

	public void setBehaviour(AbstractSteeringBehaviour behaviour) {
		behaviour.setInput(input);
		this.behaviour = behaviour;
	}
	
	public void setKinematic(Kinematic kinematic) {
		this.kinematic = kinematic;
	}

	public void updateState() {
		state.position = kinematic.position;
		state.orientation = kinematic.orientation;
		state.velocity = kinematic.velocity;
		state.rotation = kinematic.rotation;
	}

	public State getState() {
		updateState();

		return state;
	}

	public AvatarData getAvatarData() {
		return new AvatarData(ref, time, playerContext.getId());
	}

	public void setPlayerContext(PlayerContext playerContext) {
		this.playerContext = playerContext;
	}

	public void destroy() {
		/* sharedObject.removeAttribute(playerContext.getId()); */
	}
}
