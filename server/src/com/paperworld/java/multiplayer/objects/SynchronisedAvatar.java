package com.paperworld.java.multiplayer.objects;

import java.util.ArrayList;
import java.util.List;

import org.red5.server.api.so.ISharedObject;

import com.paperworld.java.ai.steering.Kinematic;
import com.paperworld.java.api.IBehaviour;
import com.paperworld.java.api.IInput;
import com.paperworld.java.api.ISynchronisedAvatar;
import com.paperworld.java.api.ISynchronisedScene;
import com.paperworld.java.multiplayer.data.AvatarData;
import com.paperworld.java.multiplayer.data.State;
import com.paperworld.java.multiplayer.data.SyncData;
import com.paperworld.java.multiplayer.player.PlayerContext;

public class SynchronisedAvatar implements ISynchronisedAvatar {

	public static int COUNT = 0;

	protected List<IBehaviour> behaviours = new ArrayList<IBehaviour>();

	protected ISynchronisedScene scene;

	protected int time = 0;

	protected IInput input;

	protected State state;

	protected String key;

	protected String id;

	protected PlayerContext playerContext;

	/**
	 * Default constructor.
	 */
	public SynchronisedAvatar() {
		initialise();
	}

	public SynchronisedAvatar(Kinematic kinematic) {
		initialise();
	}

	public void initialise() {
		COUNT++;

		input = new Input();
		state = new State();
	}

	@Override
	public void updateBehaviour() {
		for (IBehaviour behaviour : behaviours) {
			behaviour.apply(this);
		}
	}

	public void setUserInput(IInput input) {
		while (input.getTime() > this.time) {
			updateBehaviour();
			time++;
		}

		this.input = input;
	}

	public void updateSharedObject(ISharedObject so) {
		so
				.setAttribute(getId(), new SyncData(scene.getTime(),
						getAvatarData()));
	}

	public boolean addBehaviour(IBehaviour behaviour) {
		if (!behaviours.contains(behaviour)) {
			behaviours.add(behaviour);
			return true;
		}

		return false;
	}

	// GETTERS AND SETTERS

	public void setBehaviour(IBehaviour behaviour) {
		addBehaviour(behaviour);
	}

	public void setBehaviours(List<IBehaviour> behaviours) {
		this.behaviours = behaviours;
	}

	public void setScene(ISynchronisedScene scene) {
		this.scene = scene;
	}

	public ISynchronisedScene getScene() {
		return scene;
	}

	public IInput getInput() {
		return input;
	}

	public void setInput(IInput input) {
		this.input = input;
	}

	public State getState() {
		return state;
	}

	public void setState(State state) {
		this.state = state;
	}

	public AvatarData getAvatarData() {
		return new AvatarData(this);
	}

	public int getTime() {
		return time;
	}

	public void setTime(int time) {
		this.time = time;
	}

	@Override
	public String getId() {
		return id;
	}

	@Override
	public String getKey() {
		return key;
	}

	@Override
	public void setId(String id) {
		this.id = id;
	}

	@Override
	public void setKey(String key) {
		this.key = key;
	}

	public void setPlayerContext(PlayerContext playerContext) {
		this.playerContext = playerContext;
	}

	public void destroy() {
	}
}
