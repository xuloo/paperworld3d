package org.flashmonkey.java.rm;

public class BaseMessageService implements IMessageService {

	@Override
	public void receiveMessage(IMessage message) {
		message.read(this);
	}

	@Override
	public void sendMessage(IMessage message) {
		// TODO Auto-generated method stub

	}

}
