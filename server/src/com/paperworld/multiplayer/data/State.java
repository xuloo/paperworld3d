/* --------------------------------------------------------------------------------------
 * PaperWorld3D - building better worlds
 * --------------------------------------------------------------------------------------
 * Real-Time Multi-User Application Framework for the Flash Platform.
 * --------------------------------------------------------------------------------------
 * Copyright (C) 2008 Trevor Burton [worldofpaper@googlemail.com]
 * --------------------------------------------------------------------------------------
 * 
 * This library is free software; you can redistribute it and/or modify it under the 
 * terms of the GNU Lesser General Public License as published by the Free Software 
 * Foundation; either version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT ANY 
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A 
 * PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License along with 
 * this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, 
 * Suite 330, Boston, MA 02111-1307 USA 
 * 
 * -------------------------------------------------------------------------------------- */
package com.paperworld.multiplayer.data;

import com.brainfarm.java.util.math.Matrix;
import com.brainfarm.java.util.math.Quaternion;
import com.brainfarm.java.util.math.Vector3;


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
