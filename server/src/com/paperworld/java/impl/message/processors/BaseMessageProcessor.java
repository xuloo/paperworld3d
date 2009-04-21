package com.paperworld.java.impl.message.processors;

import com.paperworld.java.api.IPaperworldService;
import com.paperworld.java.util.AbstractProcessor;

public class BaseMessageProcessor extends AbstractProcessor {

	private IPaperworldService service;
	
	public BaseMessageProcessor(IPaperworldService messageService, Class<?> type) {
		this.service = messageService;
		addProcessable(type);
	}
	
	@Override
	public Object process(Object object) {
		return null;
	}
	
	public IPaperworldService getService() {
		return service;
	}

}
