package com.paperworld.multiplayer.data;

import com.paperworld.core.math.Matrix;
import com.paperworld.core.math.Quaternion;
import com.paperworld.core.math.Vector3;

public class State {

	public Matrix transform;

	public Vector3 position;

	public Quaternion orientation;

	public Vector3 velocity;

	public double rotation;

	public State() {
		clear();
	}

	public void clear() {
		transform = new Matrix();
		position = new Vector3();
		orientation = new Quaternion();
		velocity = new Vector3();
		rotation = 0;
	}

	public Matrix getTransform() {
		return transform;
	}

	public void setTransform(Matrix transform) {
		this.transform = transform;
	}

	public Vector3 getPosition() {
		return position;
	}

	public void setPosition(Vector3 position) {
		this.position = position;
	}

	public Quaternion getOrientation() {
		return orientation;
	}

	public void setOrientation(Quaternion orientation) {
		this.orientation = orientation;
	}

	public Vector3 getVelocity() {
		return velocity;
	}

	public void setVelocity(Vector3 velocity) {
		this.velocity = velocity;
	}

	public double getRotation() {
		return rotation;
	}

	public void setRotation(double rotation) {
		this.rotation = rotation;
	}
}
