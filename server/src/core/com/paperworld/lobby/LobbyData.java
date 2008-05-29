package com.paperworld.lobby;

import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IDataOutput;
import org.red5.io.amf3.IExternalizable;

public class LobbyData implements IExternalizable {

	public String name;
	
	public String model;
	
	public void readExternal(IDataInput input) {
		name = input.readUTF();
		model = input.readUTF();
	}

	public void writeExternal(IDataOutput output) {
		output.writeUTF(name);
		output.writeUTF(model);
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public void setModel(String model) {
		this.model = model;
	}
}
