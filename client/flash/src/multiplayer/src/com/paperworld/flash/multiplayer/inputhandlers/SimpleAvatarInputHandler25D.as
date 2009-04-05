package com.paperworld.flash.multiplayer.inputhandlers 
{
	import com.paperworld.flash.multiplayer.api.ISynchronisedAvatar;
	import com.paperworld.flash.multiplayer.data.State;
	import com.paperworld.flash.util.input.Input;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;
			

	/**
	 * @author Trevor
	 */
	public class SimpleAvatarInputHandler25D extends AbstractInputHandler
	{
		private static var logger:ILogger = LoggerFactory.getLogger("Paperworld");

		public var moveForwardAmount : Number = 1;

		public var moveBackAmount : Number = 1;

		public var moveRightAmount : Number = 1;

		public var moveLeftAmount : Number = 1;

		public var turnLeftAmount : Number = 1;

		public var turnRightAmount : Number = 1;		

		public function SimpleAvatarInputHandler25D()
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
