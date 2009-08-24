package org.flashmonkey.java.api;

import org.flashmonkey.java.core.objects.BasicState;

public interface IBehaviour {

	public void update(int time, IInput input, BasicState state);
}
