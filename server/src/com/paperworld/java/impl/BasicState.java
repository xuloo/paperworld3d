package com.paperworld.java.impl;

import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IDataOutput;

import com.jme.math.Quaternion;
import com.jme.math.Vector3f;
import com.paperworld.java.api.IState;

public class BasicState implements IState {

	protected Vector3f position;
	
	protected Quaternion orientation;
	
	protected int time;
	
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

	}

	@Override
	public void writeExternal(IDataOutput output) {

	}
}
