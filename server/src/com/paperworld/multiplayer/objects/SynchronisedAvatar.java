package com.paperworld.multiplayer.objects;

import org.red5.server.api.so.ISharedObject;

import com.actionengine.java.data.Input;
import com.brainfarm.java.data.State;
import com.brainfarm.java.steering.AbstractSteeringBehaviour;
import com.brainfarm.java.steering.Kinematic;
import com.paperworld.java.api.IAvatar;
import com.paperworld.multiplayer.data.AvatarData;
import com.paperworld.multiplayer.data.SyncData;
import com.paperworld.multiplayer.data.TimedInput;
import com.paperworld.multiplayer.player.PlayerContext;

public class SynchronisedAvatar implements IAvatar {

	protected Kinematic kinematic;

	protected int time = 0;

	public Input input;

	public State state;

	public String ref;

	protected PlayerContext playerContext;

	public AbstractSteeringBehaviour behaviour;

	public SynchronisedAvatar() {
		initialise();
	}

	public SynchronisedAvatar(Kinematic kinematic) {
		initialise();
	}

	public void initialise() {
		input = new Input();
		state = new State();
	}

	@Override
	public void updateBehaviour() {
		behaviour.getSteering(state, input);
	}

	@Override
	public void updateInput(TimedInput input) {
		while (input.time > time) {
			updateBehaviour();
			time++;
		}

		this.input = input.getInput();
	}

	public void updateState() {
		state.position = kinematic.position;
		state.orientation = kinematic.orientation;
		state.velocity = kinematic.velocity;
		state.rotation = kinematic.rotation;
	}

	public void updateSharedObject(ISharedObject so) {
		so.setAttribute(playerContext.getId(), new SyncData(time, input,
				getState()));
	}

	public Kinematic getKinematic() {
		return kinematic;
	}

	public void setKinematic(Kinematic kinematic) {
		this.kinematic = kinematic;
	}

	public void setBehaviour(AbstractSteeringBehaviour behaviour) {
		this.behaviour = behaviour;
	}

	public State getState() {
		updateState();

		return state;
	}

	public Input getInput() {
		return input;
	}

	public void setState(State state) {
		this.state = state;
	}

	public AvatarData getAvatarData() {
		return new AvatarData(ref, time, playerContext.getId());
	}

	public int getTime() {
		return time;
	}

	public void setPlayerContext(PlayerContext playerContext) {
		this.playerContext = playerContext;
	}

	public void destroy() {
	}
}
