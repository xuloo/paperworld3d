package com.paperworld.flash.phys
{
	import com.actionengine.flash.input.Input;
	import com.brainfarm.flash.util.math.Quaternion;
	import com.brainfarm.flash.util.math.Vector3;	

	/**
	 * @author Trevor
	 */
	public class PhysicsObject 
	{
		/**
		 * Evaluate all derivative values for the physics state at time t.
		 * 
		 * @param input the current input data.
		 * @param planes the set of all collision planes in the scene.
		 * @param state the physics state of the cube.
		 */
		public function evaluate(input : Input, planes : Array, state : PhysicsState) : Derivative
		{
			var output : Derivative = new Derivative( );
			output.velocity = state.velocity;
			output.spin = state.spin;
			
			forces( input, planes, state, output.force, output.torque );
			
			return output;
		}

		/**
		 * Evaluate derivative values for the physics state at future time t+dt 
		 * using the specified set of derivatives to advance dt seconds from the 
		 * specified physics state.
		 * 
		 * @param input the current input data.
		 * @param planes the set of all collision planes in the scene.
		 * @param state the physics state of the cube at the start of the timestep.
		 * @param dt the time in seconds to advance forward.
		 * @param derivative the set of derivative values to use to advance forward in time from state.
		 */	
		public function evaluate2(input : Input, planes : Array, state : PhysicsState, dt : Number, derivative : Derivative) : Derivative
		{
			state.position += derivative.velocity.returnScale( dt );
			state.momentum += derivative.force.returnScale( dt );
			state.orientation += derivative.spin.scale( dt );
			state.angularMomentum += derivative.torque.returnScale( dt );
			
			state.recalculate( );
			
			var output : Derivative;
			output.velocity = state.velocity;
			output.spin = state.spin;
			
			forces( input, planes, state, output.force, output.torque );
			
			return output;
		}

		/**
		 * Integrate physics state forward by dt seconds.
		 * Uses an RK4 integrator to accurately numerically integrate with error O(5).
		 * This involves evaluating derivatives at multiple points in the timestep
		 * using the Cube::evaluate method then updating the primary state values as
		 * a weighted sum of these values then finally recalculating secondary state.
		 */	
		public function integrate(input : Input, planes : Array, state : PhysicsState, dt : Number) : void
		{
			var a : Derivative = evaluate( input, planes, state );
			var b : Derivative = evaluate2( input, planes, state, dt * 0.5f, a );
			var c : Derivative = evaluate2( input, planes, state, dt * 0.5f, b );
			var d : Derivative = evaluate2( input, planes, state, dt, c );
			
			//state.position += 1.0 / 6.0 * dt * (a.velocity + 2.0 * (b.velocity + c.velocity) + d.velocity);
			var bcVel : Vector3 = b.velocity.returnAddition( c.velocity );
			var bcVel2 : Vector3 = bcVel.returnScale( 2.0 );
			var bcdVel : Vector3 = bcVel2.returnAddition( d.velocity );
			var abcdVel : Vector3 = a.velocity.returnAddition( bcdVel );
			var positionInc : Vector3 = abcdVel.returnScale( 1.0 / 6.0 * dt );
			state.position = state.position.returnAddition( positionInc );
			
			//state.momentum += 1.0 / 6.0 * dt * (a.force + 2.0 * (b.force + c.force) + d.force);
			var bcMom : Vector3 = b.force.returnAddition( c.force );
			var bcMom2 : Vector3 = bcMom.returnScale( 2.0 );
			var bcdMom : Vector3 = bcMom2.returnAddition( d.force );
			var abcdMom : Vector3 = a.force.returnAddition( bcdMom );
			var momentumInc : Vector3 = abcdMom.returnScale( 1.0 / 6.0 * dt );
			
			state.momentum = state.momentum.returnAddition( momentumInc );

			//state.orientation += 1.0 / 6.0 * dt * (a.spin + 2.0 * (b.spin + c.spin) + d.spin);
			var bcOrient : Quaternion = Quaternion.add( b.spin, c.spin );
			var bcOrient2 : Quaternion = bcOrient.scale( 2.0 );
			var bcdOrient : Quaternion = Quaternion.add( bcOrient2, d.spin );
			var abcdOrient : Quaternion = Quaternion.add( a.spin, bcdOrient );
			var orientationInc : Quaternion = abcdOrient.scale( 1.0 / 6.0 * dt );
			
			state.orientation = Quaternion.add( state.orientation, orientationInc );
			
			//state.angularMomentum += 1.0 / 6.0 * dt * (a.torque + 2.0 * (b.torque + c.torque) + d.torque);
			var bcAngMom : Vector3 = b.torque.returnAddition( c.torque );
			var bcAngMom2 : Vector3 = bcAngMom.returnScale( 2.0 );
			var bcdAngMom : Vector3 = bcAngMom2.returnAddition( d.torque );
			var abcdAngMom : Vector3 = a.torque.returnAddition( bcdAngMom );
			var angularMomentumInc : Vector3 = abcdAngMom.returnScale( 1.0 / 6.0 * dt );
			
			state.angularMomentum = state.angularMomentum.returnAddition( angularMomentumInc );
			
			state.recalculate( );
		}

		/**
		 * Calculate force and torque for physics state at time t.
		 * Due to the way that the RK4 integrator works we need to calculate
		 * force implicitly from state rather than explictly applying forces
		 * to the rigid body once per update. This is because the RK4 achieves
		 * its accuracy by detecting curvature in derivative values over the
		 * timestep so we need our force values to supply the curvature.
		 */	
		public function forces(input : Input, planes : Array, state : PhysicsState, force : Vector3, torque : Vector3) : void
		{
			force.clear( );
			torque.clear( );
			
			gravity( force );
			damping( state, force, torque );
			collision( planes, state, force, torque );
			//control( input, state, force, torque );
		}

		/**
		 * Calculate gravity force.
		 * 
		 * @param force the force accumulator.
		 */	
		public function gravity(force : Vector3) : void
		{
			force.y -= 9.8;
		}

		/**
		 * Calculate a simple linear and angular damping force.
		 * This roughly simulates energy loss due to heat dissipation
		 * or air resistance or whatever you like.
		 * 
		 * @param state the current cube physics state.
		 * @param force the force accumulator.
		 * @param torque the torque accumulator.
		 */	
		public function damping(state : PhysicsState, force : Vector3, torque : Vector3) : void
		{
			var linear : Number = 0.001;
			var angular : Number = 0.001;
			
			force -= state.velocity.returnScale( linear );
			torque -= state.angularVelocity.returnScale( angular );
		}

		/**
		 * Calculate collision response force and torque.
		 * 
		 * This is a very basic collision response implemented at the force
		 * level by simply checking each vertex of the cube against each plane
		 * in the scene. For each cube vertex that is inside a plane a set of
		 * penalty forces and friction forces are applied to simulate collision
		 * response. See Cube::collisionForPoint for details.
		 * 
		 * @param planes the set of collision planes in the scene.
		 * @param state the current cube physics state.
		 * @param force the force accumulator.
		 * @param torque the torque accumulator.
		 */	
		public function collision(planes : Array, state : PhysicsState, force : Vector3, torque : Vector3) : void
		{
			var a : Vector3 = state.bodyToWorld.multiplyVector( new Vector3( -1, -1, -1 ).returnScale( state.size * 0.5 ) );
			var b : Vector3 = state.bodyToWorld.multiplyVector( new Vector3( +1, -1, -1 ).returnScale( state.size * 0.5 ) );
			var c : Vector3 = state.bodyToWorld.multiplyVector( new Vector3( +1, +1, -1 ).returnScale( state.size * 0.5 ) );
			var d : Vector3 = state.bodyToWorld.multiplyVector( new Vector3( -1, +1, -1 ).returnScale( state.size * 0.5 ) );
			var e : Vector3 = state.bodyToWorld.multiplyVector( new Vector3( -1, -1, +1 ).returnScale( state.size * 0.5 ) );
			var f : Vector3 = state.bodyToWorld.multiplyVector( new Vector3( +1, -1, +1 ).returnScale( state.size * 0.5 ) );
			var g : Vector3 = state.bodyToWorld.multiplyVector( new Vector3( +1, +1, +1 ).returnScale( state.size * 0.5 ) );
			var h : Vector3 = state.bodyToWorld.multiplyVector( new Vector3( -1, +1, +1 ).returnScale( state.size * 0.5 ) );
			
			for (var i : int = 0; i < planes.length ; i++)
			{
				collisionForPoint( state, force, torque, a, planes[i] );
				collisionForPoint( state, force, torque, b, planes[i] );
				collisionForPoint( state, force, torque, c, planes[i] );
				collisionForPoint( state, force, torque, d, planes[i] );
				collisionForPoint( state, force, torque, e, planes[i] );
				collisionForPoint( state, force, torque, f, planes[i] );
				collisionForPoint( state, force, torque, g, planes[i] );
				collisionForPoint( state, force, torque, h, planes[i] );
			}
		}

		/**
		 * Calculate collision response force and torque for a point against a plane.
		 * 
		 * If the point is inside the plane then a penalty force is applied to push
		 * the point out. A damping force is also applied to make the collision inelastic
		 * otherwise the cube would bounce off plane without losing any energy.
		 * 
		 * Velocity constraint forces are also applied when the point is inside the plane
		 * and the point is moving further into the plane. This tightens up the collision
		 * response from what would be achieved using penetration depth penalty forces
		 * alone giving a more realistic result.
		 * 
		 * An approximation of tangential friction force is also applied. This is not
		 * true coulomb friction which would be proportional to the normal force between
		 * the two objects, instead it is more of a rolling type friction proportional
		 * to the tangential velocity between the two surfaces. This gives basically
		 * correct effects.
		 * 
		 * Finally please note that this collision response is very basic. The correct
		 * way to implement this would be to develop a solver which could simultaneously
		 * satisify a number of constaints. The tradeoff made here is that we allow some
		 * softness in the collision response to make the calculations easier. This
		 * small amount of give during collision lets us calculate collision response
		 * easily without needing a complicated solver and without the jitter that you
		 * normally see in an impulse based collision response.
		 * 
		 * @param state the current cube physics state.
		 * @param force the force accumulator.
		 * @param torque the torque accumulator.
		 * @param point the point to check for collision.
		 * @param plane the collision plane.
		 */
		public function collisionForPoint(state : PhysicsState, force : Vector3, torque : Vector3, point : Vector3, plane : Plane) : void
		{
			var c : Number = 10;
			var k : Number = 100;
			var b : Number = 5;
			var f : Number = 3;
			
			var penetration : Number = plane.constant - point.dot( plane.normal );
			
			if (penetration > 0)
			{
				var velocity : Vector3 = state.angularVelocity.cross( point.returnSubtraction( state.position ) ).returnAddition( state.velocity );
	
				var relativeSpeed : Number = -plane.normal.dot( velocity );
				
				if (relativeSpeed > 0)
				{
					var collisionForce : Vector3 = plane.normal.returnScale( (relativeSpeed * c) );

					force += collisionForce;
					torque += (point.returnSubtraction( state.position )).cross( collisionForce );
				}
				
				var tangentialVelocity : Vector3 = velocity.returnAddition( plane.normal.returnScale( relativeSpeed ) );
				var frictionForce : Vector3 = tangentialVelocity.returnScale( f ).negate( );

				force += frictionForce;
				torque += (point.returnSubtraction( state.position )).cross( frictionForce );
	
				var penaltyForce : Vector3 = plane.normal.returnScale( penetration * k );

				force += penaltyForce;
				torque += (point.returnSubtraction( state.position )).cross( penaltyForce );
				
				var dampingForce : Vector3 = plane.normal.returnScale( relativeSpeed * penetration * b );

				force += dampingForce;
				torque += (point.returnSubtraction( state.position )).cross( dampingForce );
			}
		}
	}
}
