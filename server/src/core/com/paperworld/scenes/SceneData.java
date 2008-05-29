package com.paperworld.scenes;

import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IDataOutput;
import org.red5.io.amf3.IExternalizable;

public class SceneData implements IExternalizable {

	public String name;

	public String image;
	
	public String model;

	public SceneData() {

	}
	
	public SceneData(String name) {
		this.name = name;
	}

	public void readExternal(IDataInput input) {
		name = input.readUTF();
		image = input.readUTF();
		model = input.readUTF();
	}

	public void writeExternal(IDataOutput output) {
		output.writeUTF(name);
		output.writeUTF(image);
		output.writeUTF(model);
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public void setModel(String model) {
		this.model = model;
	}
}
