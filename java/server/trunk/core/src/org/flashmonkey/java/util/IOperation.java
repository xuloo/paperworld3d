package org.flashmonkey.java.util;

import net.schst.EventDispatcher.IEventDispatcher;

public interface IOperation extends IEventDispatcher {

	public void handleComplete();
	
	public void handleError();
}
