package com.paperworld.multiplayer.connectors 
{
	import com.paperworld.multiplayer.events.ServerSyncEvent;	
	
	/**
	 * @author Trevor
	 */
	public interface ConnectorListener 
	{
		function onLocalAvatarSync(event : ServerSyncEvent) : void;
		
		function onRemoteAvatarSync(event : ServerSyncEvent) : void;
		
		function onAvatarDelete(event : ServerSyncEvent) : void;
	}
}
