package com.paperworld.java.impl;

import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IDataOutput;
import org.red5.io.amf3.IExternalizable;

import com.jme.math.Quaternion;
import com.jme.math.Vector3f;
import com.paperworld.java.api.IState;

public class FuckingTestObject implements IExternalizable {

	public float px = 100.0f;
	
	public float py = 100.0f;
	
	public float pz = 100.0f;
	
	public float ox = 100.0f;
	
	public float oy = 100.0f;
	
	public float oz = 100.0f;
	
	public float ow = 100.0f;
	
	public FuckingTestObject() {
		
	}
	
	@Override
	public void readExternal(IDataInput input) {
		px = input.readFloat();
		py = input.readFloat();
		pz = input.readFloat();
		ox = input.readFloat();
		oy = input.readFloat();
		oz = input.readFloat();
		ow = input.readFloat();
	}

	@Override
	public void writeExternal(IDataOutput output) {
		output.writeFloat(px);
		output.writeFloat(py);
		output.writeFloat(pz);
		output.writeFloat(ox);
		output.writeFloat(oy);
		output.writeFloat(oz);
		output.writeFloat(ow);
	}
}
