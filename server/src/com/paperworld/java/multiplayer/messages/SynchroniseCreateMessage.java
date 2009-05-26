package com.paperworld.java.multiplayer.messages;

import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IDataOutput;

import com.paperworld.java.api.IInput;
import com.paperworld.java.api.IState;
import com.paperworld.java.api.message.ISynchroniseCreateMessage;
import com.paperworld.java.impl.BasicState;

public class SynchroniseCreateMessage extends BaseMessage implements
		ISynchroniseCreateMessage {

	private String playerId;
	
	private String objectId;
	
	private IInput input;
	
	private BasicState state;
	
	public SynchroniseCreateMessage() {
		
	}
	
	@Override
	public String getPlayerId() {
		return playerId;
	}

	@Override
	public void setPlayerId(String playerId) {
		this.playerId = playerId;
	}
	
	@Override
	public String getObjectId() {
		return objectId;
	}
	
	@Override
	public void setObjectId(String objectId) {
		this.objectId = objectId;
	}
	
	@Override
	public IInput getInput() {
		return input;
	}
	
	@Override
	public void setInput(IInput input) {
		this.input = input;		
	}

	@Override
	public BasicState getState() {
		return state;
	}	

	@Override
	public void setState(BasicState state) {
		this.state = state;
	}
	
	@Override
	public void readExternal(IDataInput input) {
		super.readExternal(input);
		
		playerId = input.readUTF();
		objectId = input.readUTF();
		
		this.input = (IInput) input.readObject();
		state = (BasicState) input.readObject();
	}

	@Override
	public void writeExternal(IDataOutput output) {
		super.writeExternal(output);
		
		output.writeUTF(playerId);
		output.writeUTF(objectId);
		
		output.writeObject(input);
		output.writeObject(state);
	}
}
