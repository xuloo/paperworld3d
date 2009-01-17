package com.paperworld.multiplayer.behaviour;

import java.lang.reflect.Method;

import com.actionengine.api.IInput;
import com.paperworld.java.api.ISynchronisedAvatar;

public class ActOnceInputStateDependantBehaviour extends InputStateDependentBehaviour {
	
	protected boolean isActing = false;

	@SuppressWarnings("unchecked")
	@Override
	public void apply(ISynchronisedAvatar avatar) {
		IInput input = avatar.getInput();

		try {
			String prop = Character.toUpperCase(dependentProperty.charAt(0))
					+ dependentProperty.substring(1);
			String mname = "get" + prop;
			Class[] types = new Class[] {};
			Method method = input.getClass().getMethod(mname, types);
			Object result = method.invoke(input, new Object[0]);

			if ((Boolean) result) {
				if (!isActing) {
					isActing = true;
					action.act();
				}				
			} else {
				if (isActing) {
					isActing = false;
				}
			}
		} catch (Exception e) {

		}
	}
}
