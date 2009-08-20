package org.paperworld.flash.api.multiplayer.messages
{
	import org.paperworld.flash.core.objects.State;
		
	public interface IServerSyncMessage extends IPlayerSyncMessage
	{
		function get state():State;	
		function set state(state:State):void;
	}
}