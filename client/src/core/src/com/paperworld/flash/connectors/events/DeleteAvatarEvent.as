package com.paperworld.flash.connectors.events 
{
	import com.paperworld.flash.connectors.ServerEventTypes;	
	import com.paperworld.flash.connectors.IConnector;
	import com.paperworld.flash.connectors.events.ConnectorEvent;	

	/**
	 * @author Trevor
	 */
	public class DeleteAvatarEvent extends ConnectorEvent 
	{
		public var id : String;

		public function DeleteAvatarEvent(connector : IConnector, id : String)
		{
			super( ServerEventTypes.AVATAR_DELETE, connector );
			
			this.id = id;
		}
	}
}
