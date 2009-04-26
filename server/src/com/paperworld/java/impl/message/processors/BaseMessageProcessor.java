package com.paperworld.java.impl.message.processors;

import com.paperworld.java.api.IPaperworldService;
import com.paperworld.java.util.AbstractProcessor;

public class BaseMessageProcessor extends AbstractProcessor {

	private IPaperworldService service;
	
	public BaseMessageProcessor(IPaperworldService service, Class<?> type) {
		this(service);
		addProcessable(type);
	}
	
	public BaseMessageProcessor(IPaperworldService service) {
		this.service = service;
	}
	
	@Override
	public Object process(Object object) {
		return null;
	}
	
	public IPaperworldService getService() {
		return service;
	}

}
