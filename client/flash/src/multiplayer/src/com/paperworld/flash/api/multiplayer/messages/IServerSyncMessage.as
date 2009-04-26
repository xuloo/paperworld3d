package com.paperworld.flash.api.multiplayer.messages
{
	import com.paperworld.flash.multiplayer.data.State;
	
	public interface IServerSyncMessage extends IPlayerSyncMessage
	{
		function get state():State;	
		function set state(state:State):void;
	}
}