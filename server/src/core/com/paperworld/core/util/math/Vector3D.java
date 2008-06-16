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
package com.paperworld.core.util.math;

public class Vector3D {
	public double x;

	public double y;

	public double z;

	public Vector3D() {
		x = 0.0;
		y = 0.0;
		z = 0.0;
	}

	public Vector3D(double x, double y, double z) {
		this.x = x;
		this.y = y;
		this.z = z;
	}
	
	public Vector3D(Vector3D from, Vector3D to){
		x = to.x - from.x;
		y = to.y - from.y;
		z = to.z - from.z;
	}

	/**
	 * Modulo
	 */
	public double length() {
		return Math.sqrt(this.x * this.x + this.y * this.y + this.z * this.z);
	}

	public double lengthSquared() {
		return x * x + y * y + z * z;
	}

	public void scale(double s) {
		x *= s;
		y *= s;
		z *= s;
	}

	/**
	 * Normalize.
	 */
	public void normalise() {
		double mod = length();

		if (mod != 0 && mod != 1) {
			this.x /= mod;
			this.y /= mod;
			this.z /= mod;
		}
	}

	/**
	 * Returns a new Number3D object that is a clone of the original instance
	 * with the same three-dimensional values.
	 * 
	 * @return A new Number3D instance with the same three-dimensional values as
	 *         the original Number3D instance.
	 */
	public Vector3D copy() {
		return new Vector3D(x, y, z);
	}
	
	public void add(Vector3D other){
		x += other.x;
		y += other.y;
		z += other.z;
	}
	
	public Vector3D returnAddition(Vector3D other){
		return new Vector3D(x + other.x, y + other.y, z + other.z);
	}

	public static Vector3D sub(Vector3D v0, Vector3D v1) {
		return new Vector3D(v0.x - v1.x, v0.y - v1.y, v0.z - v1.z);
	}

	public Vector3D returnSubtraction(Vector3D other) {
		return new Vector3D(x -= other.x, y -= other.y, z -= other.z);
	}

	public Vector3D returnScale(Double s) {
		return new Vector3D(x *= s, y *= s, z *= s);
	}

	public void clear() {
		x = 0.0;
		y = 0.0;
		z = 0.0;
	}

	public boolean equals(Vector3D other) {
		return x == other.x && y == other.y && z == other.z;
	}

	public boolean notEquals(Vector3D other) {
		return x != other.x || y != other.y || z != other.z;
	}
	
	public Vector3D returnNegative() {
		return new Vector3D(-x, -y, -z);
	}
	
	public Vector3D returnCross(Vector3D other){
		return new Vector3D((y * other.z) - (z * other.y), 
							(z * other.x) - (x * other.z), 
							(x * other.y) - (y * other.x));
	}
	
	public void setX(double x) {
		this.x = x;
	}
	
	public void setY(double y) {
		this.y = y;
	}
	
	public void setZ(double z) {
		this.z = z;
	}

	public String toString() {
		return "Vector3D(" + x + ", " + y + ", " + z + ")";
	}
	
	public void reset(double newx, double newy, double newz)
	{
		x = newx; 
		y = newy; 
		z = newz; 
	}

	public Vector3D clone()
	{
		return new Vector3D(x, y, z);
	}
}
