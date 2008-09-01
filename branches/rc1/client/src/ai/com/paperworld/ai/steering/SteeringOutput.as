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
package com.paperworld.ai.steering 
{
	import com.paperworld.core.interfaces.Equalable;	
	import com.paperworld.core.BaseClass;
	import com.paperworld.util.math.Vector3;		

	/**
	 * SteeringOutput is a movement requested by the steering system.
     *
     * It consists of linear and angular components. The components
     * may be interpreted as forces and torques when output from a
     * full dynamic steering behaviour, or as velocity and rotation
     * when output from a kinematic steering behaviour. In the former
     * case, neither force nor torque take account of mass, and so
     * should be thought of as linear and angular acceleration.
     * 
     * @author Trevor
     */
	public class SteeringOutput extends BaseClass
	{
		/**
         * The linear component of the steering action.
         */
        public var linear:Vector3;

        /**
         * The angular component of the steering action.
         */
        public var angular:Number;

        /**
         * Creates a new steering action with the given linear and
         * angular changes.
         *
         * @param linear The initial linear change to give the
         * SteeringOutput.
         *
         * @param angular The initial angular change to give the
         * SteeringOutput.
         */
        public function SteeringOutput(linear:Vector3 = null, angular:Number = 0)
        {
        	this.linear = linear || new Vector3();
        	this.angular = angular;
        }

        /**
         * Zeros the linear and angular changes of this steering action.
         */
        public function clear():void
        {
            linear.clear();
            angular = 0;
        }

        /**
         * Checks that the given steering action is equal to this.
         * SteeringOutputs are equal if their linear and angular
         * changes are equal.
         */
        override public function equals(other : Equalable) : Boolean
        {
        	var o:SteeringOutput = SteeringOutput(other);
			return linear.equals(o.linear) &&  angular == o.angular;
        }
	}
}
