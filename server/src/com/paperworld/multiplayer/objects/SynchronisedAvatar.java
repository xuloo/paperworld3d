package com.paperworld.multiplayer.objects;

import org.red5.server.api.so.ISharedObject;

import com.actionengine.java.data.Input;
import com.brainfarm.java.data.State;
import com.brainfarm.java.steering.Kinematic;
import com.paperworld.java.api.IAvatar;
import com.paperworld.java.api.IBehaviour;
import com.paperworld.java.api.IInputHandler;
import com.paperworld.java.api.IScene;
import com.paperworld.java.inputhandlers.InputHandler;
import com.paperworld.multiplayer.data.AvatarData;
import com.paperworld.multiplayer.data.SyncData;
import com.paperworld.multiplayer.player.PlayerContext;

public class SynchronisedAvatar implements IAvatar {

	protected Kinematic kinematic;

	protected IScene scene;

	protected int time = 0;

	protected Input input;

	protected State state;

	protected String ref;

	protected PlayerContext playerContext;

	protected IInputHandler inputHandler;

	public SynchronisedAvatar() {
		initialise();
	}

	public SynchronisedAvatar(Kinematic kinematic) {
		initialise();
	}

	public void initialise() {
		inputHandler = new InputHandler();
		input = new Input();
		state = new State();
	}

	@Override
	public void updateBehaviour() {
		inputHandler.handleInput(this, input);
	}

	public void setUserInput(int time, Input input) {
		while (time > this.time) {
			updateBehaviour();
			time++;
		}

		this.input = input;
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

	public void setScene(IScene scene) {
		this.scene = scene;
	}

	public IScene getScene() {
		return scene;
	}

	public Kinematic getKinematic() {
		return kinematic;
	}

	public void setKinematic(Kinematic kinematic) {
		this.kinematic = kinematic;
	}

	public void setBehaviour(IBehaviour behaviour) {
		inputHandler.addBehaviour(behaviour);
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
	
	public void setInputHandler(IInputHandler inputHandler) {
		System.out.println("setting input handler " + inputHandler);
		this.inputHandler = inputHandler;
	}

	public void destroy() {
	}
}
