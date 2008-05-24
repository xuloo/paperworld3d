package com.paperworld.core.avatar.behaviour;

import com.paperworld.ai.core.steering.AbstractSteeringBehaviour;
import com.paperworld.core.avatar.AvatarInput;
import com.paperworld.core.avatar.AvatarState;
import com.paperworld.core.util.DisplayObject3D;
import com.paperworld.core.util.math.Matrix3D;
import com.paperworld.core.util.math.Quaternion;
import com.paperworld.core.util.math.Vector3D;

public class KinematicBehaviour2D extends AbstractSteeringBehaviour {

	private double toDEGREES  = 180/Math.PI;
	private double toRADIANS  = Math.PI/180;
	
	public static double EPSILON = 0.005;

	public Double maxAcceleration = 5.0;

	public Double maxSpeed = 50.0;

	public Double minSpeed = -maxSpeed;

	private Vector3D rotationAxis = DisplayObject3D.UP;
	
	private double rotationAngle = 0.0;

	@Override
	public void run() {
		AvatarInput input = character.getInput();
		AvatarState state = character.getState();
		DisplayObject3D displayObject = character.getDisplayObject();

		if (input.forward)
			state.speed = (state.speed + maxAcceleration > maxSpeed) ? maxSpeed
					: state.speed + maxAcceleration;

		if (input.back)
			state.speed = (state.speed - maxAcceleration < minSpeed) ? minSpeed
					: state.speed - maxAcceleration;

		//displayObject.moveForward(state.speed);
		
		translate(displayObject, state.speed);
		rotate(displayObject, input.mouseX);
		
		

		
		
		state.setTransform(displayObject.transform);
		state.setOrientation(Quaternion.createFromMatrix(state
				.returnTransform()));

	}
	
	private void translate(DisplayObject3D displayObject, double distance) {
		Vector3D vector = new Vector3D(  0.0,  0.0,  1.0 );

		Matrix3D.rotateAxis( displayObject.transform, vector );

		displayObject.setX( displayObject.getX() + distance * vector.x );
		displayObject.setY( displayObject.getY() + distance * vector.y );
		displayObject.setZ( displayObject.getZ() + distance * vector.z );
	}
	
	private void rotate(DisplayObject3D displayObject, double angle) {
		angle *= toRADIANS;

		Vector3D vector = rotationAxis.copy();

		Matrix3D.rotateAxis( displayObject.transform, vector );
		Matrix3D m = Matrix3D.rotationMatrix( vector.x, vector.y, vector.z, angle );
		
		displayObject.transform.calculateMultiply3x3( m , displayObject.transform );
	}
	
	public void setRotationAxis(Vector3D angle) {
		rotationAxis = angle;
	}

	private Double getRotationAngle(Quaternion qr){
		
		return Math.acos(qr.w) * 2 * toRADIANS;
		
		/*Vector3D axis = new Vector3D();	
		
	    double cos_angle  = qr.w;
	    double angle      = Math.acos( cos_angle ) * 2 * RADIANS;
	    double sin_angle  = Math.sqrt( 1.0 - cos_angle * cos_angle );
	    
	    System.out.println("sin_angle: " + Math.abs( sin_angle ));
	    
	    if ( Math.abs( sin_angle ) < 0.0005 )
	    {
	    	sin_angle = 1.0;
	    }

	    axis.x = qr.x / sin_angle;
	    axis.y = qr.y / sin_angle;
	    axis.z = qr.z / sin_angle;
		System.out.println("axis: (" + axis.x + ", " + axis.y + ", " + axis.z + ") angle: " + angle);
		return angle;*/
	}
}
