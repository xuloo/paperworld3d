package org.paperworld.flash.multiplayer.factory
{
	import org.paperworld.flash.api.multiplayer.ISynchronisedAvatar;
	import org.paperworld.flash.multiplayer.api.IAvatarFactory;	

	/**
	 * @author Trevor
	 */
	public class PranaContextAvatarFactory implements IAvatarFactory 
	{
		public function getAvatar(key : String) : ISynchronisedAvatar
		{
			return null;//ISynchronisedAvatar( CoreContext.getInstance( ).getObject( key ) );
		}
	}
}
