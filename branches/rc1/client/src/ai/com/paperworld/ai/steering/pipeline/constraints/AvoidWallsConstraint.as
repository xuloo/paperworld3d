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
package com.paperworld.ai.steering.pipeline.constraints 
{
	import com.paperworld.ai.collision.CollisionDetector;
	import com.paperworld.ai.steering.Kinematic;
	import com.paperworld.ai.steering.pipeline.SteeringConstraint;
	import com.paperworld.util.math.Vector3;	

	/**
	 * @author Trevor
	 */
	public class AvoidWallsConstraint extends SteeringConstraint 
	{
		protected var _collisionDetector : CollisionDetector;

		/**
		 * Function calculating the suggested goal when a collision is
		 * detected.
		 *
		 * @param actor The position and course from which
		 * collisions were probed.
		 *
		 * The result is written directly to the suggestedGoal member
		 * variable.  The time member variable is not altered. The
		 * caller must set it to the appropriate value before calling
		 * this method.
		 */
		protected function calcResolution(actor : Kinematic) : void
		{
		}

		/**
		 * This flag indicates whether or not to perform 3d collision
		 * resolution.  It defaults to true.
		 */
		public var use3dRestitution : Boolean;

		/**
		 * Distance from the wall that the constraint will try to keep
		 * at.  Default value is 1.
		 */
		public var safetyMargin : Number;

		/**
		 * The distance by which the tip of the collision vector
		 * (normal to the wall) is shifted along the wall to produce
		 * the correction vector.
		 */
		public var shift : Number;

		/**
		 * The absolute velocity of the suggested goal. If this value
		 * is negative then the current actor speed is used. Default
		 * value is -1.
		 */
		public var goalSpeed : Number;

		/**
		 * Collision point and normal vector returned by the collision
		 * detector.
		 */
		public var cp : Vector3;

		public var cv : Vector3;

		/**
		 * Constructor.
		 *
		 * @param d Pointer to an instance of CollisionDetector.
		 */
		public function AvoidWallsConstraint(collisionDetector : CollisionDetector)
		{
			super( );
        	
			_collisionDetector = collisionDetector;                
		}

		override public function initialise() : void
		{
			use3dRestitution = true;
			safetyMargin = 1;
			shift = 1;
			goalSpeed = -1;
		}

		/**
		 * Set the collision detector currently in use by this constraint.
		 *
		 * @param cd Pointer to the collision detector to use.
		 */
		public function set collisionDetector(cd : CollisionDetector):void
		{
			_collisionDetector = cd;
		}

		/**
		 * Runs the constraint.
		 */
		override public function run() : void
		{
		}
	}
}
