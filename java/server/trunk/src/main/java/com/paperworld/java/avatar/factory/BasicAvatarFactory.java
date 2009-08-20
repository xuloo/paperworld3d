package com.paperworld.java.avatar.factory;

import com.paperworld.java.api.IAvatar;
import com.paperworld.java.api.IAvatarFactory;
import com.paperworld.java.api.IPlayer;
import com.paperworld.java.avatar.BasicAvatar;

public class BasicAvatarFactory implements IAvatarFactory {

	public BasicAvatarFactory() {
		
	}
	
	@Override
	public IAvatar getAvatar(IPlayer player) {
		IAvatar avatar = new BasicAvatar();
		avatar.setOwner(player);
		
		return avatar;
	}

}
