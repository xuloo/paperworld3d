package com.paperworld.flash.multiplayer.factory 
{
	import com.paperworld.flash.api.multiplayer.ISynchronisedAvatar;
	import com.paperworld.flash.multiplayer.api.IAvatarFactory;

	/**
	 * @author Trevor
	 */
	public class RemoteAndLocalAvatarFactory implements IAvatarFactory 
	{
		public function getAvatar(key : String) : ISynchronisedAvatar
		{
			return null;//ISynchronisedAvatar( CoreContext.getInstance( ).getObject( 'local.' + key ) );
		}
	}
}
