/*
 * --------------------------------------------------------------------------------------
 * PaperWorld3D - building better worlds
 * --------------------------------------------------------------------------------------
 * Realtime 3D Multi-User Application Framework for the Flash Platform.
 * --------------------------------------------------------------------------------------
 * Copyright (C) 2008 Influxis [http://www.influxis.com]
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
 * --------------------------------------------------------------------------------------
 */
package com.paperworld.core.avatar;

import com.paperworld.core.util.math.Matrix3D;
import com.paperworld.core.util.math.Quaternion;
import com.paperworld.core.util.math.Vector3D;

/**
 * AvatarState holds all the data about an Avatar's speed, position and
 * orientation. It is passed to the Remote Shared Object so that the minimum
 * amount of data is passed over the wire to the clients.
 * 
 * @author Trevor
 * 
 */
public class AvatarState {
	/**
	 * A Matrix3D object containing values that affect the scaling, rotation,
	 * and translation of the display object.
	 */

	// Transformation Matrix Values.
	public double n11 = 0.0;
	public double n12 = 0.0;
	public double n13 = 0.0;
	public double n14 = 0.0;
	public double n21 = 0.0;
	public double n22 = 0.0;
	public double n23 = 0.0;
	public double n24 = 0.0;
	public double n31 = 0.0;
	public double n32 = 0.0;
	public double n33 = 0.0;
	public double n34 = 0.0;
	public double n41 = 0.0;
	public double n42 = 0.0;
	public double n43 = 0.0;
	public double n44 = 0.0;

	// Quaternion
	public double qx = 0.0;
	public double qy = 0.0;
	public double qz = 0.0;
	public double qw = 0.0;

	// Position
	public double px = 0.0;
	public double py = 0.0;
	public double pz = 0.0;

	// Speed
	public double speed = 0.0;
	
	// Rotation
	public double rotation = 0.0;

	/**
	 * Sets the transformation matrix.
	 * 
	 * @param matrix
	 */
	public void setTransform(Matrix3D matrix) {
		n11 = matrix.n11;
		n12 = matrix.n12;
		n13 = matrix.n13;
		n14 = matrix.n14;
		n21 = matrix.n21;
		n22 = matrix.n22;
		n23 = matrix.n23;
		n24 = matrix.n24;
		n31 = matrix.n31;
		n32 = matrix.n32;
		n33 = matrix.n33;
		n34 = matrix.n34;
		n41 = matrix.n41;
		n42 = matrix.n42;
		n43 = matrix.n43;
		n44 = matrix.n44;
	}

	public Matrix3D returnTransform() {
		return new Matrix3D(new Double[] { n11, n12, n13, n14, n21, n22, n23,
				n24, n31, n32, n33, n34, n41, n42, n43, n44 });
	}

	public Quaternion returnQuaternion() {
		return new Quaternion(qx, qy, qz, qw);
	}

	/**
	 * Sets the Quaternion orientation.
	 * 
	 * @param quaternion
	 */
	public void setOrientation(Quaternion quaternion) {
		qx = quaternion.x;
		qy = quaternion.y;
		qz = quaternion.z;
		qw = quaternion.w;
	}

	/**
	 * Sets the position.
	 * 
	 * @param position
	 */
	public void setPosition(Vector3D position) {
		px = position.x;
		py = position.y;
		pz = position.z;
	}
	
	public Vector3D returnPosition(){
		return new Vector3D(n14, n24, n34);
	}

	/**
	 * Sets the speed.
	 * 
	 * @param speed
	 */
	public void setSpeed(double speed) {
		this.speed = speed;
	}
	
	public AvatarState copy() {
		AvatarState copy = new AvatarState();
		
		copy.setTransform(returnTransform());
		copy.setOrientation(returnQuaternion());
		copy.setSpeed(speed);
		
		return copy;
	}

	/**
	 * Constructor.
	 */
	public AvatarState() {
	}
}
