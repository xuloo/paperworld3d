package org.red5.server.net.udp;

import java.lang.reflect.Constructor;
import java.nio.ByteOrder;

import org.apache.mina.common.ByteBuffer;
import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IExternalizable;
import org.red5.io.udp.Converter;

public class UDPInput implements IDataInput {

	private ByteBuffer buffer;
	
	public UDPInput(ByteBuffer buffer) {
		this.buffer = buffer;
		buffer.order(ByteOrder.LITTLE_ENDIAN);
	}
	
	@Override
	public ByteOrder getEndian() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean readBoolean() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public byte readByte() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void readBytes(byte[] arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public void readBytes(byte[] arg0, int arg1) {
		// TODO Auto-generated method stub

	}

	@Override
	public void readBytes(byte[] arg0, int arg1, int arg2) {
		// TODO Auto-generated method stub

	}

	@Override
	public double readDouble() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public float readFloat() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int readInt() {
		return buffer.getInt();
	}

	@Override
	public String readMultiByte(int arg0, String arg1) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Object readObject() {
		short id = buffer.getShort();
		System.out.println("Reading Object " + id);
		Class<?> T = Converter.getRegisteredClass(id);
		Object o;
		try {
			o = T.newInstance();
			System.out.println("o " + o);
			((IExternalizable) o).readExternal(this);
			return o;
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public short readShort() {
		return buffer.getShort();
	}

	@Override
	public String readUTF() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String readUTFBytes(int arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int readUnsignedByte() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public long readUnsignedInt() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int readUnsignedShort() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void setEndian(ByteOrder arg0) {
		// TODO Auto-generated method stub

	}

}
