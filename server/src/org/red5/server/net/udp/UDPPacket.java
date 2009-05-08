package org.red5.server.net.udp;

import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IDataOutput;
import org.red5.io.amf3.IExternalizable;


public class UDPPacket implements IExternalizable {

	private UDPHeader header;
	
	public UDPPacket() {
		
	}

	@Override
	public void readExternal(IDataInput input) {
		header = (UDPHeader) input.readObject();
		System.out.println("READING EXTERNAL " + header.getSequence());
	}

	@Override
	public void writeExternal(IDataOutput output) {
		// TODO Auto-generated method stub
		
	}
	
}
