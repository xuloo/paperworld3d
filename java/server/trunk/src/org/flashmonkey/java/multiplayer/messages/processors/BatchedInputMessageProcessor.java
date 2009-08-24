package org.flashmonkey.java.multiplayer.messages.processors;

import org.flashmonkey.java.api.IPaperworldService;
import org.flashmonkey.java.connection.messages.processors.BaseMessageProcessor;
import org.flashmonkey.java.multiplayer.messages.BatchedInputMessage;
import org.flashmonkey.java.multiplayer.messages.PlayerSyncMessage;
import org.flashmonkey.java.util.AbstractProcessor;

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
