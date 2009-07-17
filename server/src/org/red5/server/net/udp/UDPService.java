package org.red5.server.net.udp;

import java.io.IOException;
import java.net.InetSocketAddress;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;

import org.apache.mina.common.ByteBuffer;
import org.apache.mina.common.IdleStatus;
import org.apache.mina.common.IoAcceptor;
import org.apache.mina.common.IoHandler;
import org.apache.mina.common.IoSession;
import org.apache.mina.transport.socket.nio.DatagramAcceptor;
import org.red5.server.api.IClient;
import org.red5.server.api.IConnection;

import com.paperworld.java.impl.BaseService;

public class UDPService extends BaseService implements IoHandler {
	
	private int port = 5150;
	
	private ConcurrentMap<IoSession, IConnection> pendingConnections = new ConcurrentHashMap<IoSession, IConnection>();
	
	private ConcurrentMap<IoSession, IConnection> connections = new ConcurrentHashMap<IoSession, IConnection>();
	
	public UDPService() {
		IoAcceptor acceptor = new DatagramAcceptor();
		
		try {
			acceptor.bind(new InetSocketAddress(port), this);			
		} catch (IOException ex) {
			System.out.println("Unable to bind udp handler to port " + port);
		}
	}
	
	@Override
	public void exceptionCaught(IoSession session, Throwable exception)
			throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void messageReceived(IoSession session, Object message) throws Exception {
		System.out.println("Message Received");
		/*if (!connections.containsKey(session))
		{
			if (pendingConnections.containsKey(session)) {
				IConnection connection = pendingConnections.remove(session);
				connections.put(session, connection);
				application.connect(connection, application.getScope(), new Object[]{"this", "that"});
			}
		}*/
		ByteBuffer buffer = (ByteBuffer) message;
		System.out.println("MESSAGE " + buffer);
		UDPInput input = new UDPInput(buffer);
		UDPPacket packet = new UDPPacket();
		packet.readExternal(input);
	}

	@Override
	public void messageSent(IoSession session, Object message) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void sessionClosed(IoSession session) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void sessionCreated(IoSession session) throws Exception {
		System.out.println("session created");

		/*if (!pendingConnections.containsKey(session) && 
				!connections.containsKey(session)) {
			IConnection connection = new UDPConnection(session);
			IClient client = getApplication().getContext().getClientRegistry().newClient(null);
			connection.initialize(client);
			
			pendingConnections.put(session, connection);
			
			System.out.println("scope " + application.getScope());
		}*/
	}

	@Override
	public void sessionIdle(IoSession session, IdleStatus status) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void sessionOpened(IoSession session) throws Exception {
		// TODO Auto-generated method stub

	}

}
