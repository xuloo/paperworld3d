package com.paperworld.core.avatar.behaviour;

import com.paperworld.actions.Action;
import com.paperworld.core.avatar.Avatar;
import com.paperworld.core.avatar.AvatarState;
import com.paperworld.core.util.math.Matrix3D;
import com.paperworld.core.util.math.Quaternion;
import com.paperworld.core.util.math.Vector3D;

public class SteeringAction extends Action {

	private Avatar character;
	
	private SteeringOutput steering;
	
	public SteeringAction() {
		super();
	}
	
	@Override
	public void act() {
		Quaternion q = steering.angular;
		Vector3D l = steering.linear;
		
		Matrix3D matrix = Matrix3D.quaternion2matrix(q.x, q.y, q.z, q.w, null);
		matrix.n14 = l.x;
		matrix.n24 = l.y;
		matrix.n34 = l.z;
		
		AvatarState state = character.getState();
		state.setTransform(matrix);
		state.setOrientation(q);
	}
	
	public void setCharacter(Avatar character) {
		this.character = character;
	}
	
	public void setSteering(SteeringOutput steering) {
		this.steering = steering;
	}
}
