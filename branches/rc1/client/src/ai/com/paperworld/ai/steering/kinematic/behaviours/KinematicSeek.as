/**
 * This class is a port of the original C++ code from the book:
 * 
 * 'Artificial Intelligence for Games' by Ian Millington 
 * Published by Morgan Kaufmann (ISBN: 0124977820)
 * 
 * Adaptations from original source:
 * 
 * - Added BaseClass methods.
 */
package com.paperworld.ai.steering.kinematic.behaviours 
{
	import com.paperworld.ai.steering.SteeringOutput;		

	/**
	 * @author Trevor
	 */
	public class KinematicSeek extends TargetedKinematicMovement 
	{
		override public function getSteering(output : SteeringOutput) : void
		{
			// First work out the direction
			output.linear = target;
			output.linear.minusEq( character.position );

			// If there is no direction, do nothing
			if (output.linear.squareMagnitude > 0)
			{
				output.linear.normalise( );
				output.linear.multiplyEq( maxSpeed );
			}
		}
	}
}
