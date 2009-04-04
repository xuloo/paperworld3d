package com.paperworld.java.multiplayer.behaviour;

import java.lang.reflect.Method;

import com.paperworld.java.api.IInput;
import com.paperworld.java.api.ISynchronisedAvatar;

public class InputStateDependentBehaviour extends ActionAwareBehaviour {

	protected String dependentProperty;

	public InputStateDependentBehaviour() {

	}

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
				action.act();
			}
		} catch (Exception e) {

		}
	}

	public void setDependentProperty(String dependentProperty) {
		this.dependentProperty = dependentProperty;
	}
}
