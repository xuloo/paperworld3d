package com.paperworld.java.api;

import com.paperworld.java.api.ISynchronisedAvatar;
import com.paperworld.java.exceptions.AvatarNotFoundException;

public interface IAvatarFactory {
	
	public ISynchronisedAvatar getAvatar(String key);
}
