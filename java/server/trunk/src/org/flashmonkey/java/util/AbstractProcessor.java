package org.flashmonkey.java.util;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public abstract class AbstractProcessor {

	private List<Class<?>> types = Collections.synchronizedList(new ArrayList<Class<?>>());

	public void addProcessable(Class<?> processable) {
		types.add(processable);
	}
	
	public boolean canProcess(Class<?> clazz) {
		for (Class<?> type : types) {
			if (clazz.equals(type)) {
				return true;
			}
		}
		
		return false;
	}
	
	public abstract Object process(Object object);
}
