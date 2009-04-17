package com.paperworld.flash.multiplayer.inputhandlers 
{
	import com.paperworld.flash.api.multiplayer.IBehaviour;
	import com.paperworld.flash.api.multiplayer.ISynchronisedAvatar;	

	/**
	 * @author Trevor
	 */
	public class AbstractInputHandler implements IBehaviour 
	{
		protected var _next : IBehaviour;

		public function get next() : IBehaviour
		{
			return _next;
		}

		public function set next(behaviour : IBehaviour) : void 
		{
			_next = behaviour;
		}

		public function apply(avatar : ISynchronisedAvatar) : void
		{
			if (next) 
			{
				next.apply( avatar );	
			}
		}
	}
}
