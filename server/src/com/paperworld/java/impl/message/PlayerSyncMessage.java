package com.paperworld.java.impl.message;

import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IDataOutput;

import com.paperworld.java.api.IInput;
import com.paperworld.java.api.message.IPlayerSyncMessage;

public class PlayerSyncMessage extends BaseMessage implements IPlayerSyncMessage {

	private IInput input;
	
	private int time;
	
	public PlayerSyncMessage() {
		super(null);
	}
	
	public PlayerSyncMessage(String senderId, int time, IInput input) {
		super(senderId);
		
		this.time = time;
		this.input = input;
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
	public int getTime() {
		return time;
	}	

	@Override
	public void setTime(int time) {
		this.time = time;
	}
	
	@Override
	public void readExternal(IDataInput input) {
		super.readExternal(input);
		
		time = input.readInt();
		this.input = (IInput) input.readObject();
	}

	@Override
	public void writeExternal(IDataOutput output) {
		super.writeExternal(output);
		
		output.writeInt(time);
		output.writeObject(input);
	}
}
