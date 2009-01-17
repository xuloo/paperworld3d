package com.paperworld.java.actions;

import com.actionengine.java.action.Action;
import com.paperworld.java.api.ISynchronisedScene;

public class InjectAvatarAction extends Action {

	private ISynchronisedScene scene;
	
	private String key;
	
	public InjectAvatarAction() {
		
	}
	
	public InjectAvatarAction(ISynchronisedScene scene) {
		setScene(scene);
	}
	
	public InjectAvatarAction(ISynchronisedScene scene, String key) {
		setScene(scene);
		setKey(key);
	}
		
	public void act() {
		scene.setAvatar(key);
	}
	
	public void setScene(ISynchronisedScene scene) {
		this.scene = scene;
	}
	
	public ISynchronisedScene getScene() {
		return scene;
	}
	
	public void setKey(String key) {
		this.key = key;
	}
	
	public String getKey() {
		return key;
	}

}
