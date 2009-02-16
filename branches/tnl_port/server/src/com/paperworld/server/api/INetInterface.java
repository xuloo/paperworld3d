package com.paperworld.server.api;

import java.util.List;

public interface INetInterface {

	public void processConnections();
	
	//public void sendTo(IConnection conn, PacketStream stream);
	
	public void setConnection(INetConnection connection);
	
	public void setConnections(List<INetConnection> connections);
} 