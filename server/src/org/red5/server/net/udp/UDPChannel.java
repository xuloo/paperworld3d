package org.red5.server.net.udp;

import org.red5.server.api.stream.IClientStream;
import org.red5.server.net.rtmp.RTMPConnection;
import org.red5.server.net.rtmp.event.IRTMPEvent;
import org.red5.server.net.rtmp.message.Header;
import org.red5.server.net.rtmp.message.Packet;

public class UDPChannel {

	/**
     * UDP connection used to transfer packets.
     */
	private UDPConnection connection;
	
	/**
     * Channel id
     */
    private int id;
    
    /**
     * Creates channel from connection and channel id
     * @param conn                Connection
     * @param channelId           Channel id
     */
	public UDPChannel(UDPConnection conn, int channelId) {
		connection = conn;
		id = channelId;
	}
	
	/**
     * Writes packet from event data to RTMP connection.
	 *
     * @param event          Event data
     */
    public void write(IRTMPEvent event) {
		write(event, 3);
	}
	
	/**
     * Writes packet from event data to RTMP connection and stream id.
	 *
     * @param event           Event data
     * @param streamId        Stream id
     */
    private void write(IRTMPEvent event, int streamId) {

		final Header header = new Header();
		final Packet packet = new Packet(header, event);

		header.setChannelId(id);
		header.setTimer(event.getTimestamp());
		header.setStreamId(streamId);
		header.setDataType(event.getDataType());
		if (event.getHeader() != null) {
			header.setTimerRelative(event.getHeader().isTimerRelative());
		}

		// should use RTMPConnection specific method.. 
		connection.write(packet);

	}
}
