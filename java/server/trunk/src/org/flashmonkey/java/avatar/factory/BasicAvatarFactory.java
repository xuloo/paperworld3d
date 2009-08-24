package org.flashmonkey.java.avatar.factory;

import org.flashmonkey.java.api.IAvatar;
import org.flashmonkey.java.api.IAvatarFactory;
import org.flashmonkey.java.api.IPlayer;
import org.flashmonkey.java.avatar.BasicAvatar;

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
