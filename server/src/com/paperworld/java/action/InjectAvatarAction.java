package com.paperworld.java.action;

import com.paperworld.java.api.IPaperworldService;

public class InjectAvatarAction extends Action {

	private IPaperworldService service;
	
	private String key;
	
	public InjectAvatarAction() {
		
	}
	
	public InjectAvatarAction(IPaperworldService scene) {
		setScene(scene);
	}
	
	public InjectAvatarAction(IPaperworldService scene, String key) {
		setScene(scene);
		setKey(key);
	}
		
	public void act() {
		//service.setAvatar(key);
	}
	
	public void setScene(IPaperworldService scene) {
		this.service = scene;
	}
	
	public IPaperworldService getScene() {
		return service;
	}
	
	public void setKey(String key) {
		this.key = key;
	}
	
	public String getKey() {
		return key;
	}

}
