package org.paperworld.java.avatar.factory;

import org.paperworld.java.api.IAvatar;
import org.paperworld.java.api.IAvatarFactory;
import org.paperworld.java.api.IPlayer;
import org.paperworld.java.avatar.BasicAvatar;

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
