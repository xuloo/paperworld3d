package com.paperworld.java.actions;

import com.actionengine.java.action.Action;
import com.paperworld.java.api.IScene;

public class InjectAvatarAction extends Action {

	private IScene scene;
	
	private String key;
	
	public InjectAvatarAction() {
		
	}
	
	public InjectAvatarAction(IScene scene) {
		setScene(scene);
	}
	
	public InjectAvatarAction(IScene scene, String key) {
		setScene(scene);
		setKey(key);
	}
	
	@Override 
	public void act() {
		scene.setAvatar(key);
	}
	
	public void setScene(IScene scene) {
		this.scene = scene;
	}
	
	public IScene getScene() {
		return scene;
	}
	
	public void setKey(String key) {
		this.key = key;
	}
	
	public String getKey() {
		return key;
	}

}
