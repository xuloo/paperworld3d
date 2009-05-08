package org.red5.server.net.udp;

import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;
import java.util.concurrent.atomic.AtomicInteger;

import org.apache.mina.common.ByteBuffer;
import org.apache.mina.common.IoSession;
import org.red5.io.amf3.Output;
import org.red5.server.BaseConnection;
import org.red5.server.api.service.IPendingServiceCall;
import org.red5.server.api.service.IPendingServiceCallback;
import org.red5.server.api.service.IServiceCall;
import org.red5.server.api.service.IServiceCapableConnection;
import org.red5.server.net.rtmp.RTMPConnection;
import org.red5.server.net.rtmp.event.Invoke;
import org.red5.server.net.rtmp.message.Packet;
import org.red5.server.service.PendingCall;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class UDPConnection extends BaseConnection implements
		IServiceCapableConnection {

	/**
	 * Logger
	 */
	private static Logger log = LoggerFactory.getLogger(RTMPConnection.class);
	
	/**
	 * Connection channels
	 * 
	 * @see org.red5.server.net.rtmp.Channel
	 */
	private ConcurrentMap<Integer, UDPChannel> channels = new ConcurrentHashMap<Integer, UDPChannel>();
	
	private IoSession ioSession;
	
	/**
	 * Identifier for remote calls.
	 */
	private AtomicInteger invokeId = new AtomicInteger(1);
	
	/**
	 * Hash map that stores pending calls and ids as pairs.
	 */
	private ConcurrentMap<Integer, IPendingServiceCall> pendingCalls = new ConcurrentHashMap<Integer, IPendingServiceCall>();

	private int localSequence = 0;
	
	private int remoteSequence = 0;
	
	public UDPConnection(IoSession ioSession) {
		super(PERSISTENT, null, null, 0, null, null, null);
		
		this.ioSession = ioSession;
	}
	
	/**
	 * Generate next invoke id.
	 * 
	 * @return Next invoke id for RPC
	 */
	public int getInvokeId() {
		return invokeId.incrementAndGet();
	}
	
	/**
	 * Register pending call (remote function call that is yet to finish).
	 * 
	 * @param invokeId Deferred operation id
	 * @param call Call service
	 */
	public void registerPendingCall(int invokeId, IPendingServiceCall call) {
		pendingCalls.put(invokeId, call);
	}
	
	/**
	 * Return channel by id.
	 * 
	 * @param channelId Channel id
	 * @return Channel by id
	 */
	public UDPChannel getChannel(int channelId) {
		final UDPChannel value = new UDPChannel(this, channelId);
		UDPChannel result = channels.putIfAbsent(channelId, value);
		if (result == null) {
			result = value;
		}
		return result;
	}
	
	@Override
	public void invoke(IServiceCall call) {
		invoke(call, 3);
	}

	@Override
	public void invoke(String method) {
		invoke(method, null, null);
	}

	@Override
	public void invoke(IServiceCall call, int channel) {
		log.warn("invoking remote method {} on UDPConnection", call.toString());
		// We need to use Invoke for all calls to the client
		Invoke invoke = new Invoke();
		invoke.setCall(call);
		invoke.setInvokeId(getInvokeId());
		if (call instanceof IPendingServiceCall) {
			registerPendingCall(invoke.getInvokeId(),
					(IPendingServiceCall) call);
		}
		getChannel(channel).write(invoke);
	}

	@Override
	public void invoke(String method, IPendingServiceCallback callback) {
		invoke(method, null, callback);
	}

	@Override
	public void invoke(String method, Object[] params) {
		invoke(method, params, null);
	}

	@Override
	public void invoke(String method, Object[] params, IPendingServiceCallback callback) {
		IPendingServiceCall call = new PendingCall(method, params);
		if (callback != null) {
			call.registerCallback(callback);
		}
		invoke(call);
	}

	@Override
	public void notify(IServiceCall arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public void notify(String arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public void notify(IServiceCall arg0, int arg1) {
		// TODO Auto-generated method stub

	}

	@Override
	public void notify(String arg0, Object[] arg1) {
		// TODO Auto-generated method stub

	}

	@Override
	public Encoding getEncoding() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int getLastPingTime() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void ping() {
		// TODO Auto-generated method stub

	}
	
	public void write(Packet out) {
		log.warn("writing packet {} into session {}", new Object[]{out, ioSession});
		if (ioSession != null) {
			//writingMessage(out);
			//ioSession.write(out);
			
			ByteBuffer buf = ByteBuffer.allocate(0); // 1kb
			//output = new Output(buf);
			//ioSession.write(output.buf());
		}
	}
	
	@Override
	public long getWrittenBytes() {
		return 0L;
	}
	
	@Override
	public long getReadBytes() {
		return 0L;
	}

}
