package org.flashmonkey.java.message.processor;

import org.flashmonkey.java.connection.red5.service.api.IPaperworldService;
import org.flashmonkey.java.util.AbstractMessageProcessor;

public class BaseMessageProcessor extends AbstractMessageProcessor {

	protected IPaperworldService service;
	
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
