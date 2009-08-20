package org.paperworld.flash.api.multiplayer
{
	import org.paperworld.flash.api.IInput;
	
	public interface ISyncManager
	{
		function register(avatar:ISynchronisedAvatar):void;
		
		function unRegister(avatar:ISynchronisedAvatar):void;
		
		function handleAvatarMove(id:String, time:int, input:IInput):void;
	}
}