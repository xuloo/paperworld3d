package org.paperworld.java.multiplayer.messages.processors;

import org.paperworld.java.api.IPaperworldService;
import org.paperworld.java.multiplayer.messages.BatchedInputMessage;
import org.paperworld.java.multiplayer.messages.PlayerSyncMessage;
import org.paperworld.java.util.AbstractProcessor;

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
