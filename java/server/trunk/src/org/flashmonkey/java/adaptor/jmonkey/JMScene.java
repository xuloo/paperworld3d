package org.flashmonkey.java.adaptor.jmonkey;

import java.util.List;

import org.flashmonkey.java.api.IAvatar;
import org.flashmonkey.java.api.IScene;

import com.jme.app.SimpleHeadlessApp;
import com.jme.scene.Spatial;

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
