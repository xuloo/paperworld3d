package com.paperworld.java.adaptor.jmonkey;

import com.jme.bounding.BoundingBox;
import com.jme.math.Quaternion;
import com.jme.scene.Spatial;
import com.jme.scene.shape.Box;
import com.paperworld.java.adaptor.jmonkey.behaviour.AvatarForwardBehaviour;
import com.paperworld.java.api.IInput;
import com.paperworld.java.api.IState;
import com.paperworld.java.avatar.BasicAvatar;
import com.paperworld.java.behaviour.CompositeBehaviour;
import com.paperworld.java.state.BasicState;

public class JMAvatar extends BasicAvatar {
	
	protected Spatial spatial;
	
	public JMAvatar() {
		init();
	}
	
	public void init() {
		initBehaviour();
		initSpatial();
	}
	
	public void initBehaviour() {
		CompositeBehaviour compBehaviour = new CompositeBehaviour();
		compBehaviour.addBehaviour(new AvatarForwardBehaviour(30));
		
		behaviour = compBehaviour;
	}
	
	public void initSpatial() {
		spatial = new Box();
		spatial.setModelBound(new BoundingBox());
		spatial.updateModelBound();
	}
	
	@Override
	public void updateUserInput(int time, IInput input) {
		super.updateUserInput(time, input);
		
		//System.out.println("position" + spatial.getLocalTranslation().x + " " + spatial.getLocalTranslation().y + " " + spatial.getLocalTranslation().z);
		//System.out.println("position" + state.getPosition().x + " " + state.getPosition().y + " " + state.getPosition().z);

		//System.out.println("forward: " + input.getMoveForward());
	}
	
	@Override
	public void update() {
		super.update();
		
		spatial.setLocalTranslation(state.px, state.py, state.pz);
		spatial.setLocalRotation(new Quaternion(state.ox, state.oy, state.oz, state.ow));
		
		//System.out.println("position" + spatial.getLocalTranslation().x + " " + spatial.getLocalTranslation().y + " " + spatial.getLocalTranslation().z);
	}

	@Override
	public BasicState getState() {		
		return state;
	}

}
