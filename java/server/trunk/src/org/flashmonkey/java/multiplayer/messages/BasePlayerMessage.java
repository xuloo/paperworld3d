package org.flashmonkey.java.multiplayer.messages;

import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IDataOutput;

import org.flashmonkey.java.api.message.IPlayerMessage;
import org.flashmonkey.java.connection.messages.BaseMessage;

public abstract class BasePlayerMessage extends BaseMessage implements IPlayerMessage {

	private String playerId;
	
	public BasePlayerMessage() {
		super(null);
	}
	
	public BasePlayerMessage(String senderId, String playerId) {
		super(senderId);
		
		this.playerId = playerId;
	}
	
	public String getPlayerId() {
		return playerId;
	}
	
	public void setPlayerId(String playerId) {
		this.playerId = playerId;
	}
	
	@Override
	public void readExternal(IDataInput input) {
		super.readExternal(input);
		
		playerId = input.readUTF();
	}

	@Override
	public void writeExternal(IDataOutput output) {
		super.writeExternal(output);
		
		output.writeUTF(playerId);
	}

}
