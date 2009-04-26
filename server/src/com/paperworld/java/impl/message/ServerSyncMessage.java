package com.paperworld.java.impl.message;

import org.red5.annotations.DontSerialize;
import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IDataOutput;

import com.paperworld.java.api.IInput;
import com.paperworld.java.api.IState;
import com.paperworld.java.api.message.IServerSyncMessage;

public class ServerSyncMessage extends PlayerSyncMessage implements IServerSyncMessage {

	private IState state;
	
	public ServerSyncMessage() {
		
	}
	
	public ServerSyncMessage(String senderId, String objectId, int time, IInput input, IState state) {
		super(senderId, objectId, time, input);
		
		this.state = state;
	}
	
	public IState getState() {
		return state;
	}
	
	public void setState(IState state) {
		this.state = state;
	}
	
	@Override
	public void readExternal(IDataInput input) {
		super.readExternal(input);

		state = (IState) input.readObject();
	}

	@Override
	public void writeExternal(IDataOutput output) {
		super.writeExternal(output);
		
		output.writeObject(state);
	}
}
