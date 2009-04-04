package com.paperworld.flash.multiplayer.factory 
{
	import com.paperworld.api.IAvatarFactory;
	import com.paperworld.api.ISynchronisedAvatar;
	import com.paperworld.api.ISynchronisedScene;	

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
