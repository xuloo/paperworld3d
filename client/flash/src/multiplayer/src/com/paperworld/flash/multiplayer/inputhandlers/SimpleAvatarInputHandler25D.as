package com.paperworld.flash.multiplayer.inputhandlers 
{
	import com.paperworld.flash.api.multiplayer.ISynchronisedAvatar;
	import com.paperworld.flash.multiplayer.data.State;
	import com.paperworld.flash.util.input.IInput;
	
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
			var input : IInput = avatar.input;
			var state : State = avatar.state;
				
			if (input != null) 
			{
				if (input.moveForward)
					state.position.z += moveForwardAmount;
					
				if (input.moveBackward)
					state.position.z -= moveBackAmount;

				if (input.moveRight)
					state.position.x += moveRightAmount;

				if (input.moveLeft)
					state.position.x -= moveLeftAmount;

				if (input.yawPositive)
					state.orientation.w += turnRightAmount;

				if (input.yawNegative)
					state.orientation.w -= turnLeftAmount;
			}		
			
			super.apply( avatar );
		}
	}
}
