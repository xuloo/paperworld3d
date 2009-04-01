package com.paperworld.flash.factory 
{
	import com.actionengine.flash.core.context.CoreContext;
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
			return ISynchronisedAvatar( CoreContext.getInstance( ).getObject( 'local.' + key ) );
		}
	}
}
