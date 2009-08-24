package org.paperworld.flash.multiplayer.inputhandlers 
{
	import org.paperworld.flash.api.IAvatar;
	import org.paperworld.flash.api.IBehaviour;	

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

		public function apply(avatar : IAvatar) : void
		{
			if (next) 
			{
				next.apply( avatar );	
			}
		}
	}
}
