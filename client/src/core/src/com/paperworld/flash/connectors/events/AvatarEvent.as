package com.paperworld.flash.connectors.events 
{
	import com.paperworld.flash.connectors.IConnector;
	import com.paperworld.flash.connectors.events.ConnectorEvent;
	import com.paperworld.flash.data.SyncData;		

	/**
	 * @author Trevor
	 */
	public class AvatarEvent extends ConnectorEvent 
	{
		public var data : SyncData;

		public function AvatarEvent(type : String, connector : IConnector, data : SyncData)
		{
			super( type, connector );
			
			this.data = data;
		}
	}
}
