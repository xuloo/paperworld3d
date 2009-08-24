package org.flashmonkey.java.api;

import org.flashmonkey.java.core.objects.BasicState;
import org.red5.server.api.IConnection;

public interface IAvatar {

	public void setBehaviour(IBehaviour behaviour);

	public void updateUserInput(int time, IInput input);

	public void setConnection(IConnection connection);

	public IConnection getConnection();

	public BasicState getState();

	public int getTime();

	public void update();

	public IInput getInput();

	public void setInput(IInput input);

	public String getId();

	public void setId(String id);

	public IPlayer getOwner();

	public void setOwner(IPlayer owner);
}
