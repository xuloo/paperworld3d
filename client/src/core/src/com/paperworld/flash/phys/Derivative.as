package com.paperworld.flash.phys
{
	import com.brainfarm.flash.util.math.Quaternion;
	import com.brainfarm.flash.util.math.Vector3;	
	
	/**
	 * Derivative values for primary state.
	 * This structure stores all derivative values for primary state in State.
	 * For example velocity is the derivative of position, force is the derivative
	 * of momentum etc. Storing all derivatives in this structure makes it easy
	 * to implement the RK4 integrator cleanly because it needs to calculate the
	 * and store derivative values at several points each timestep.
	 * 
	 * @author Trevor
	 */
	public class Derivative 
	{
		/**
		 * Velocity is the derivative of position.
		 */
		public var velocity : Vector3;                
		
		/**
		 * Force in the derivative of momentum.
		 */
		public var force : Vector3;                   
		
		/**
		 * Spin is the derivative of the orientation quaternion.
		 */
		public var spin : Quaternion;                
		
		/**
		 * Torque is the derivative of angular momentum.
		 */
		public var torque : Vector3; 
	}
}