package com.paperworld.multiplayer.behaviours 
{
	import com.brainfarm.flash.steering.SteeringOutput;	
	
	/**
	 * @author Trevor
	 */
	public class SimpleAvatarBehaviour25D extends SimpleAvatarBehaviour2D 
	{
		public function SimpleAvatarBehaviour25D()
		{
		}
		
		override public function getSteering(output : SteeringOutput) : void
		{
			output.clear();
			
			if (input != null) 
			{
				if (input.getForward( ))
					output.linear.z += moveForwardAmount;

				if (input.getBack( ))
					output.linear.z -= moveBackAmount;

				if (input.getMoveRight( ))
					output.linear.x += moveRightAmount;

				if (input.getMoveLeft( ))
					output.linear.x -= moveLeftAmount;

				if (input.getTurnRight( ))
					output.angular.w += turnRightAmount;

				if (input.getTurnLeft( ))
					output.angular.w -= turnLeftAmount;
			}
		}
	}
}
