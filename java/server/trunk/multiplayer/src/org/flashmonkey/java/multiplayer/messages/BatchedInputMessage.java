package org.flashmonkey.java.multiplayer.messages;

import org.flashmonkey.java.connection.messages.BaseMessage;
import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IDataOutput;

public class BatchedInputMessage extends BaseMessage {

	private PlayerSyncMessage[] messages;
	
	public BatchedInputMessage() {
		
	}
	
	public PlayerSyncMessage[] getMessages() {
		return messages;
	}
	
	@Override
	public void readExternal(IDataInput input) {
		super.readExternal(input);
		
		int length = input.readInt();
		if (length > 0)
		{
			messages = new PlayerSyncMessage[length];
			
			for (int i = 0; i < length; i++) {
				messages[i] = (PlayerSyncMessage) input.readObject();
			}
		}
	}

	@Override
	public void writeExternal(IDataOutput output) {
		super.writeExternal(output);
		
		if (messages != null) {
			output.writeInt(messages.length);
			
			for (int i = 0; i < messages.length; i++) {
				output.writeObject(messages[i]);
			}
		}
	}
}
