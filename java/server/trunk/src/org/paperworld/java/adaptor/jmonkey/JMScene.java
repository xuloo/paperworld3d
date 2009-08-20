package com.paperworld.java.adaptor.jmonkey;

import java.util.List;

import com.jme.app.SimpleHeadlessApp;
import com.jme.scene.Spatial;
import com.paperworld.java.api.IAvatar;
import com.paperworld.java.api.IScene;

public class JMScene extends SimpleHeadlessApp implements IScene {

	public JMScene() {
		
	}
	
	@Override
	public IAvatar addChild(IAvatar child) {
		rootNode.attachChild((Spatial) child);
		return null;
	}

	@Override
	public List<IAvatar> getChildren() {
		return null;
	}

	@Override
	public IAvatar removeChild(IAvatar child) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	protected void simpleInitGame() {
		// TODO Auto-generated method stub
		
	}

}
