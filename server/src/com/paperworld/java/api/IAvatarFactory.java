package com.paperworld.java.api;

import com.paperworld.java.api.IAvatar;
import com.paperworld.java.exceptions.AvatarNotFoundException;

public interface IAvatarFactory {
	
	public IAvatar getAvatar(String key);
}
