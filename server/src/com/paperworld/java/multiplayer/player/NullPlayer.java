package com.paperworld.java.multiplayer.player;

public class NullPlayer extends Player {

	protected static int COUNT = 0;

	protected String id;

	public NullPlayer() {
		setId("NULL_PLAYER_" + COUNT++);
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
}
