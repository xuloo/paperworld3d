package com.paperworld.multiplayer.objects 
{
	import com.paperworld.input.Input;
	import com.paperworld.multiplayer.events.ServerSyncEvent;
	import com.paperworld.multiplayer.objects.Avatar;	

	/**
	 * @author Trevor
	 */
	public class RemoteAvatar extends Avatar 
	{
		//private var logger : XrayLog = new XrayLog();

		public function RemoteAvatar()
		{
			super( );
		}

		override public function synchronise(event : ServerSyncEvent) : void
		{
			proxy.synchronise(event.data.t, event.data.state, event.data.input);
			//super.synchronise( event );
			
			client.input = event.data.input.clone( );
	
			// correct if significantly different	
			if (client.state.compare( event.data.state ))
			{
				client.snap( event.data.state );
				client.smooth( );
			}
		}
	}
}
