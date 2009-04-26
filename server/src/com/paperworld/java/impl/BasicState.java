package com.paperworld.java.impl;

import org.red5.annotations.DontSerialize;
import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IDataOutput;

import com.jme.math.Quaternion;
import com.jme.math.Vector3f;
import com.paperworld.java.api.IState;

public class BasicState implements IState {

	@DontSerialize
	private Vector3f position;
	
	@DontSerialize
	private Quaternion orientation;
	
	@DontSerialize
	private int time;
	
	public BasicState() {
		this(new Vector3f(), new Quaternion(), 0);
	}
	
	public BasicState(Vector3f position, Quaternion orientation, int time) {
		this.position = position;
		this.orientation = orientation;
		this.time = time;
	}
	
	@Override
	public Quaternion getOrientation() {
		return orientation;
	}
	
	@Override
	public void setOrientation(Quaternion orientation) {
		this.orientation = orientation;
	}

	@Override
	public Vector3f getPosition() {
		return position;
	}
	
	@Override
	public void setPosition(Vector3f position) {
		this.position = position;
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
		position.x = input.readFloat();
		position.y = input.readFloat();
		position.z = input.readFloat();
		orientation.w = input.readFloat();
		orientation.x = input.readFloat();
		orientation.y = input.readFloat();
		orientation.z = input.readFloat();
	}

	@Override
	public void writeExternal(IDataOutput output) {
		output.writeFloat(position.x);
		output.writeFloat(position.y);
		output.writeFloat(position.z);
		output.writeFloat(orientation.w);
		output.writeFloat(orientation.x);
		output.writeFloat(orientation.y);
		output.writeFloat(orientation.z);
	}
}
