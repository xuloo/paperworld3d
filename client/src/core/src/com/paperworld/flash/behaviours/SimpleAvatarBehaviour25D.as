package com.paperworld.flash.behaviours 
{
	import com.actionengine.flash.input.Input;
	import com.actionengine.flash.util.logging.Logger;
	import com.actionengine.flash.util.logging.LoggerContext;
	import com.brainfarm.flash.data.State;
	import com.paperworld.flash.behaviours.SimpleAvatarBehaviour2D;		

	/**
	 * @author Trevor
	 */
	public class SimpleAvatarBehaviour25D extends SimpleAvatarBehaviour2D 
	{
		private var logger : Logger = LoggerContext.getLogger( SimpleAvatarBehaviour25D );

		public function SimpleAvatarBehaviour25D()
		{
		}
		
		override public function getSteeringState(state : State, input : Input) : void
		{			
			if (input != null) 
			{
				if (input.getForward( ))
					state.position.z += moveForwardAmount;

				if (input.getBack( ))
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
		}
	}
}
