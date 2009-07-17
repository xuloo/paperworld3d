package com.paperworld.java.api;

import com.paperworld.java.impl.BasicState;

public interface IBehaviour {

	public void update(int time, IInput input, BasicState state);
}
