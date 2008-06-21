package com.paperworld.core.avatar.behaviour;

import com.paperworld.core.avatar.Avatar;
import com.paperworld.core.avatar.AvatarInput;
import com.paperworld.core.avatar.AvatarState;
import com.paperworld.core.util.DisplayObject3D;
import com.paperworld.core.util.math.Matrix3D;
import com.paperworld.core.util.math.Quaternion;
import com.paperworld.core.util.math.Vector3D;

public class SimpleBehaviour2D extends AbstractSteeringAction implements IAvatarBehaviour {

	private double toRADIANS  = Math.PI/180;
	
	private int speed = 5;
	
	private double lastRotation = 0;
	
	private Vector3D rotationAxis = DisplayObject3D.UP;
	
	private double rotationAngle = 0.0;	
	
	public Double maxAcceleration = 5.0;

	public Double maxSpeed = 50.0;

	public Double minSpeed = -maxSpeed;
	
	@Override
	public void act() {
				
		AvatarInput input = character.getInput();
		AvatarState state = character.getState();
		DisplayObject3D displayObject = character.getDisplayObject();
		
		//System.out.println(input.left + " : " + input.right);
		
		state.speed = 0;
		
		if (input.forward)
			state.speed = speed;
		
		if (input.back)
			state.speed = -speed;
		
		translate(displayObject, state.speed);
		//rotate(displayObject, input.mouseX);
		
		double yawAmount = 0.0;
		
		if (input.left)
			yawAmount = -1.0;
		
		if (input.right)
			yawAmount = 1.0;
		
		rotate(displayObject, yawAmount);
		
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
	
	public void update(Avatar avatar) {
		act();
	}

}
