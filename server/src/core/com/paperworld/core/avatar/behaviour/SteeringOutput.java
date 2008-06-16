package com.paperworld.core.avatar.behaviour;

import com.paperworld.core.util.math.Quaternion;
import com.paperworld.core.util.math.Vector3D;

/**
 * SteeringOutput is a movement requested by the steering system.
 * 
 * It consists of linear and angular components. The components may be
 * interpreted as forces and torques when output from a full dynamic steering
 * behaviour, or as velocity and rotation when output from a kinematic steering
 * behaviour. In the former case, neither force nor torque take account of mass,
 * and so should be thought of as linear and angular acceleration.
 */
public class SteeringOutput {
	/**
	 * The linear component of the steering action.
	 */
	public Vector3D linear;

	/**
	 * The angular component of the steering action.
	 */
	public Quaternion angular;

	/**
	 * Creates a new steering action with zero linear and angular changes.
	 */
	public SteeringOutput() {
		linear = new Vector3D();
		angular = new Quaternion();
	}

	/**
	 * Creates a new steering action with the given linear and angular changes.
	 * 
	 * @param linear
	 *            The initial linear change to give the SteeringOutput.
	 * 
	 * @param angular
	 *            The initial angular change to give the SteeringOutput.
	 */
	public SteeringOutput(Vector3D linear, Quaternion angular) {
		this.linear = linear;
		this.angular = angular;
	}
	
	public void scale(Double s){
		linear.scale(s);
		angular.scale(s);
	}
	
	public void add(SteeringOutput other){
		linear.add(other.linear);
		angular.add(other.angular);
	}

	/**
	 * Zeros the linear and angular changes of this steering action.
	 */
	public void clear() {
		linear.clear();
		angular.clear();
	}

	/**
	 * Checks that the given steering action is equal to this. SteeringOutputs
	 * are equal if their linear and angular changes are equal.
	 */
	public boolean equals(SteeringOutput other) {
		return linear.equals(other.linear) && angular.equals(other.angular);
	}

	/**
	 * Checks that the given steering action is unequal to this. SteeringOutputs
	 * are unequal if either their linear or angular changes are unequal.
	 */
	public boolean notEquals(SteeringOutput other) {
		return linear.notEquals(other.linear)
				|| angular.notEquals(other.angular);
	}
}
