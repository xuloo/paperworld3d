package com.paperworld.java.api;

import java.util.List;

public interface IScene {

	public IAvatar addChild(IAvatar child);
	
	public IAvatar removeChild(IAvatar child);
	
	public List<IAvatar> getChildren();
}
