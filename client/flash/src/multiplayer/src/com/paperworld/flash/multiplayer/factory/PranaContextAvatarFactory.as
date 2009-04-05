package com.paperworld.flash.multiplayer.factory
{
	import com.paperworld.flash.multiplayer.api.IAvatarFactory;
	import com.paperworld.flash.multiplayer.api.ISynchronisedAvatar;	

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
