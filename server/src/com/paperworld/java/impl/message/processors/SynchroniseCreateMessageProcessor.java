package com.paperworld.java.impl.message.processors;

import com.paperworld.java.api.IPaperworldService;
import com.paperworld.java.api.message.ISynchroniseCreateMessage;
import com.paperworld.java.impl.message.SynchroniseCreateMessage;

public class SynchroniseCreateMessageProcessor extends BroadcastMessageProcessor {

	public SynchroniseCreateMessageProcessor(IPaperworldService service) {
		super(service, SynchroniseCreateMessage.class);
	}
	
	@Override
	public Object process(Object object) {
		System.out.println("processing ISynchroniseCreateMessage " + ((ISynchroniseCreateMessage) object).getObjectId());
		
		getService().processSynchroniseCreateMessage((ISynchroniseCreateMessage) object);
		
		return super.process(object);
	}
}
