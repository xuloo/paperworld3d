package com.paperworld.flash.phys
{
	import com.brainfarm.flash.util.math.Matrix3D;
	import com.brainfarm.flash.util.math.Quaternion;
	import com.brainfarm.flash.util.math.Vector3;
	import com.paperworld.flash.data.State;		

	/**
	 * @author Trevor
	 */
	public class PhysicsState extends State 
	{
		/// primary physics state

		/**
		 * The position of the cube center of mass in world coordinates (meters).
		 */
        public var position:Vector3; 
        
        /**
         * The momentum of the cube in kilogram meters per second.
         */
        public var momentum:Vector3;
        
        /**
         * The orientation of the cube represented by a unit quaternion.
         */
        public var orientation:Quaternion;
        
        /**
         * angular momentum vector.
         */
        public var angularMomentum:Vector3;

        // secondary state

		/**
		 * Velocity in meters per second (calculated from momentum).
		 */
        public var velocity:Vector3;  
        
        /**
         * Quaternion rate of change in orientation.
         */
        public var spin:Quaternion;       
        
        /**
         * Angular velocity (calculated from angularMomentum).
         */
        public var angularVelocity:Vector3;  
        
        /**
         * Body to world coordinates matrix.
         */
        public var bodyToWorld : Matrix3D;   
        
        /**
         * World to body coordinates matrix.
         */
        public var worldToBody:Matrix3D;   

        /// constant state

		/**
		 * Length of the cube sides in meters.
		 */
        public var size:Number;          
        
        /**
         * Mass of the cube in kilograms.
         */
        public var mass:Number;            
        
        /**
         * Inverse of the mass used to convert momentum to velocity.
         */
        public var inverseMass:Number;    
        
        /**
         * Inertia tensor of the cube (i have simplified it to a single value due to the mass properties a cube).
         */
        public var inertiaTensor:Number;    
        
        /**
         * Inverse inertia tensor used to convert angular momentum to angular velocity.
         */
        public var inverseInertiaTensor:Number;
		
		public function PhysicsState()
		{
		}
		
        /**
         * Recalculate secondary state values from primary values.
         */
        public function recalculate():void
        {
            velocity = momentum.returnScale(inverseMass);
            angularVelocity = angularMomentum.returnScale(inverseInertiaTensor);
            orientation.normalize();
            spin = new Quaternion(0, angularVelocity.x, angularVelocity.y, angularVelocity.z).multiply(orientation).scale(0.5);
            var translation : Matrix3D = new Matrix3D();
			//translation.translate(position);
            bodyToWorld = Matrix3D.multiply(translation, orientation.matrix);
            worldToBody = Matrix3D.inverse(bodyToWorld);
        }
	}
}
