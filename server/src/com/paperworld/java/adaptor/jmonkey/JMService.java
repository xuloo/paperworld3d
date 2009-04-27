package com.paperworld.java.adaptor.jmonkey;

import com.paperworld.java.api.IAvatar;
import com.paperworld.java.api.IPlayer;
import com.paperworld.java.api.IScene;
import com.paperworld.java.impl.SimpleService;

/**
 * Extends the SimpleService class to provide an adaptor for a JMonkey scene.
 * 
 * @author Trevor
 *
 */
public class JMService extends SimpleService {
	
	IScene scene = new JMScene();
	
	public JMService() {
		
	}
	
	@Override
	public IAvatar getAvatarForPlayer(IPlayer player) {
		return new JMAvatar();
	}
}
