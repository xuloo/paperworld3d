package org.red5.server.net.udp;

import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IDataOutput;
import org.red5.io.amf3.IExternalizable;

public class UDPHeader implements IExternalizable {

	private int protocol = 0;
	
	private int sequence = 0;
	
	private int ack = 0;
	
	private int ackBitfield = 0;
	
	public UDPHeader() {
		System.out.println("UDPHeader created");
	}
	
	public int getProtocol() {
		return protocol;
	}
	
	public void setProtocol(int protocol) {
		this.protocol = protocol;
	}
	
	public int getSequence() {
		return sequence;
	}
	
	public void setSequence(int sequence) {
		this.sequence = sequence;
	}
	
	public void setAck(int ack) {
		this.ack = ack;
	}
	
	public int getAck() {
		return ack;
	}
	
	public void setAckBitfield(int ackBitfield) {
		this.ackBitfield = ackBitfield;
	}
	
	public int getAckBitfield() {
		return ackBitfield;
	}

	@Override
	public void readExternal(IDataInput input) {
		protocol = input.readInt();
		sequence = input.readInt();
		ack = input.readInt();
		ackBitfield = input.readInt();
		System.out.println("sequence: " + sequence);
	}

	@Override
	public void writeExternal(IDataOutput output) {
		// TODO Auto-generated method stub
		
	}
}
