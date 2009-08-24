package org.flashmonkey.java.api.message;

import org.red5.io.amf3.IExternalizable;

public interface IMessage extends IExternalizable {

	public String getSenderId();
	
	public void setSenderId(String id);
}
