package com.paperworld.java.multiplayer.factory;

import org.red5.server.api.IContext;

import com.paperworld.java.api.ISynchronisedAvatar;
import com.paperworld.java.api.IAvatarFactory;

public class SpringContextAvatarFactory implements IAvatarFactory {

	protected IContext context;

	@Override
	public ISynchronisedAvatar getAvatar(String key) {
		System.out.println("Getting avatar " + key + " from " + context + " " + context.getApplicationContext().containsBean(key));
		Object object = context.getApplicationContext().getBean(key);
		System.out.println("object " + object);
		if (object != null) {
			if (object instanceof ISynchronisedAvatar) {
				return (ISynchronisedAvatar) object;
			}
		}
		return null;
	}

	public void setContext(IContext context) {
		this.context = context;
	}
}
