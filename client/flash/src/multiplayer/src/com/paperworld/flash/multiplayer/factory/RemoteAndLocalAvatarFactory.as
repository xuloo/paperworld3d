package com.paperworld.flash.multiplayer.factory 
{
	import com.paperworld.flash.multiplayer.api.IAvatarFactory;
	import com.paperworld.flash.multiplayer.api.ISynchronisedAvatar;
	import com.paperworld.flash.multiplayer.api.ISynchronisedScene;	

	/**
	 * @author Trevor
	 */
	public class RemoteAndLocalAvatarFactory implements IAvatarFactory 
	{
		protected var _scene : ISynchronisedScene;

		public function getAvatar(key : String) : ISynchronisedAvatar
		{
			return null;//ISynchronisedAvatar( CoreContext.getInstance( ).getObject( 'local.' + key ) );
		}
	}
}
