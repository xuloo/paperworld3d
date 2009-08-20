package com.paperworld.java.multiplayer.messages.processors;

import com.paperworld.java.api.IPaperworldService;
import com.paperworld.java.multiplayer.messages.BatchedInputMessage;
import com.paperworld.java.multiplayer.messages.PlayerSyncMessage;
import com.paperworld.java.util.AbstractProcessor;

public class BatchedInputMessageProcessor extends BaseMessageProcessor {

	public BatchedInputMessageProcessor(IPaperworldService messageService) {
		super(messageService, BatchedInputMessage.class);
	}
	
	@Override
	public Object process(Object object) {
		BatchedInputMessage message = (BatchedInputMessage) object;
		PlayerSyncMessage[] messages = message.getMessages();
		
		if (messages.length > 0) {
			AbstractProcessor processor = new PlayerSyncMessageProcessor(getService());
			
			for (int i = 0; i < messages.length; i++) {
				processor.process(messages[i]);
			}
		}		
		
		return true;
	}
}
