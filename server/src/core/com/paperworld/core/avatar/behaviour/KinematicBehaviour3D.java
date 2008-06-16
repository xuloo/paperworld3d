package com.paperworld.core.avatar.behaviour;

import com.paperworld.core.avatar.Avatar;
import com.paperworld.core.avatar.AvatarInput;
import com.paperworld.core.avatar.AvatarState;
import com.paperworld.core.util.DisplayObject3D;
import com.paperworld.core.util.math.Quaternion;

public class KinematicBehaviour3D extends AbstractSteeringAction implements IAvatarBehaviour {

	public Double maxAcceleration = 5.0;

	public Double maxSpeed = 50.0;

	public Double minSpeed = -maxSpeed;

	public KinematicBehaviour3D() {

	}

	public void act() {

		AvatarInput input = character.getInput();
		AvatarState state = character.getState();
		DisplayObject3D displayObject = character.getDisplayObject();

		if (input.forward)
			state.speed = (state.speed + maxAcceleration > maxSpeed) ? maxSpeed
					: state.speed + maxAcceleration;

		if (input.back)
			state.speed = (state.speed - maxAcceleration < minSpeed) ? minSpeed
					: state.speed - maxAcceleration;

		displayObject.moveForward(state.speed);

		displayObject.pitch(input.mouseY);
		displayObject.yaw(input.mouseX);
		displayObject.roll(-input.mouseX);

		state.setTransform(displayObject.transform);
		state.setOrientation(Quaternion.createFromMatrix(state
				.returnTransform()));
	}

	public void update(Avatar avatar) {
		// TODO Auto-generated method stub
		act();
	}

}
