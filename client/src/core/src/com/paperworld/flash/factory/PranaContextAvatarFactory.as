package com.paperworld.flash.factory 
{
	import com.actionengine.flash.core.context.CoreContext;
	import com.paperworld.api.IAvatarFactory;
	import com.paperworld.api.ISynchronisedAvatar;	

	/**
	 * @author Trevor
	 */
	public class PranaContextAvatarFactory implements IAvatarFactory 
	{
		public function getAvatar(key : String) : ISynchronisedAvatar
		{
			return ISynchronisedAvatar( CoreContext.getInstance( ).getObject( key ) );
		}
	}
}
