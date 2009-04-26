package com.paperworld.java.impl;

import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IDataOutput;
import org.red5.io.amf3.IExternalizable;

public class NetObject implements IExternalizable {

	public NetObject() {
		System.out.println("creating NetObject");
	}
	
	@Override
	public void readExternal(IDataInput input) {
		// TODO Auto-generated method stub

	}

	@Override
	public void writeExternal(IDataOutput output) {
		// TODO Auto-generated method stub

	}

}
