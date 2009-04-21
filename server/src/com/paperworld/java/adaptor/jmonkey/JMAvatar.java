package com.paperworld.java.adaptor.jmonkey;

import com.jme.scene.Spatial;
import com.paperworld.java.api.IState;
import com.paperworld.java.impl.BasicAvatar;
import com.paperworld.java.impl.BasicState;

public class JMAvatar extends BasicAvatar {
	
	protected Spatial spatial;

	@Override
	public IState getState() {
		
		IState state = new BasicState();
		state.setPosition(spatial.getLocalTranslation());
		state.setOrientation(spatial.getLocalRotation());
		
		return state;
	}

}
