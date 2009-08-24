package org.paperworld.java.api;

import org.paperworld.java.state.BasicState;

public interface IBehaviour {

	public void update(int time, IInput input, BasicState state);
}
