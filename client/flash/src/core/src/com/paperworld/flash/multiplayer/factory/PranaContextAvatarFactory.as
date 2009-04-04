package com.paperworld.flash.multiplayer.factory
{
	import com.paperworld.api.IAvatarFactory;
	import com.paperworld.api.ISynchronisedAvatar;	

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
