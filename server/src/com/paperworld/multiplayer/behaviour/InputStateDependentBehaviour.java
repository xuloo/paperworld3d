package com.paperworld.multiplayer.behaviour;

import java.lang.reflect.Method;

import com.actionengine.java.data.Input;
import com.paperworld.java.api.IAvatar;

public class InputStateDependentBehaviour extends ActionAwareBehaviour {

	protected String dependentProperty;

	public InputStateDependentBehaviour() {

	}

	@SuppressWarnings("unchecked")
	@Override
	public void apply(IAvatar avatar) {
		Input input = avatar.getInput();

		try {
			String prop = Character.toUpperCase(dependentProperty.charAt(0))
					+ dependentProperty.substring(1);
			String mname = "get" + prop;
			Class[] types = new Class[] {};
			Method method = input.getClass().getMethod(mname, types);
			Object result = method.invoke(input, new Object[0]);
			System.out.println("RESULT: " + result);
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
