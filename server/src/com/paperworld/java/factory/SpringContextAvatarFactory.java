package com.paperworld.java.factory;

import org.red5.server.api.IContext;

import com.paperworld.java.api.IAvatar;
import com.paperworld.java.api.IAvatarFactory;

public class SpringContextAvatarFactory implements IAvatarFactory {

	protected IContext context;

	@Override
	public IAvatar getAvatar(String key) {
		System.out.println("Getting avatar " + key + " from " + context + " " + context.getApplicationContext().containsBean(key));
		Object object = context.getApplicationContext().getBean(key);
		System.out.println("object " + object);
		if (object != null) {
			if (object instanceof IAvatar) {
				return (IAvatar) object;
			}
		}
		return null;
	}

	public void setContext(IContext context) {
		this.context = context;
	}
}
