package com.paperworld.flash.behaviours 
{
	import com.paperworld.api.ISynchronisedAvatar;
	import com.paperworld.flash.data.State;
	import com.paperworld.flash.input.Input;
	import com.paperworld.flash.util.logging.Logger;
	import com.paperworld.flash.util.logging.LoggerContext;
			

	/**
	 * @author Trevor
	 */
	public class SimpleAvatarBehaviour25D extends AbstractBehaviour
	{
		private var logger : Logger = LoggerContext.getLogger( SimpleAvatarBehaviour25D );

		public var moveForwardAmount : Number = 1;

		public var moveBackAmount : Number = 1;

		public var moveRightAmount : Number = 1;

		public var moveLeftAmount : Number = 1;

		public var turnLeftAmount : Number = 1;

		public var turnRightAmount : Number = 1;		

		public function SimpleAvatarBehaviour25D()
		{
		}

		override public function apply(avatar : ISynchronisedAvatar) : void
		{		
			var input : Input = avatar.getInput( );
			var state : State = avatar.getState( );
				
			if (input != null) 
			{
				if (input.getMoveForward( ))
					state.position.z += moveForwardAmount;
					
				if (input.getMoveBack( ))
					state.position.z -= moveBackAmount;

				if (input.getMoveRight( ))
					state.position.x += moveRightAmount;

				if (input.getMoveLeft( ))
					state.position.x -= moveLeftAmount;

				if (input.getTurnRight( ))
					state.orientation.w += turnRightAmount;

				if (input.getTurnLeft( ))
					state.orientation.w -= turnLeftAmount;
			}		
			
			super.apply( avatar );
		}
	}
}
