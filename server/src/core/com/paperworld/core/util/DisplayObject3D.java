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
package com.paperworld.core.util;

import com.paperworld.collision.BoundingSphere;
import com.paperworld.collision.ICollidable;
import com.paperworld.core.util.math.Matrix3D;
import com.paperworld.core.util.math.Vector3D;

public class DisplayObject3D 
{
	public Matrix3D transform;
	
	public ICollidable collisionDetector;
	
	static private double toDEGREES  = 180/Math.PI;
	static private double toRADIANS  = Math.PI/180;
	
	/**
	* Relative directions.
	*/
	static public Vector3D FORWARD   = new Vector3D(  0.0,  0.0,  1.0 );
	static public Vector3D BACKWARD  = new Vector3D(  0.0,  0.0, -1.0 );
	static public Vector3D LEFT      = new Vector3D( -1.0,  0.0,  0.0 );
	static public Vector3D RIGHT     = new Vector3D(  1.0,  0.0,  0.0 );
	static public Vector3D UP        = new Vector3D(  0.0,  1.0,  0.0 );
	static public Vector3D DOWN      = new Vector3D(  0.0, -1.0,  0.0 );
	
	public DisplayObject3D() 
	{
		transform = new Matrix3D();
		collisionDetector = new BoundingSphere(100.0);
	}
	
	public Vector3D getPosition() {
		return new Vector3D(transform.n14, transform.n24, transform.n34);
	}
	
	/**
	* An Number that sets the X coordinate of a object relative to the origin of its parent.
	*/
	public Double getX()
	{
		return transform.n14;
	}

	public void setX( double value )
	{
		transform.n14 = value;
	}
	
	/**
	* An Number that sets the Y coordinate of a object relative to the origin of its parent.
	*/
	public Double getY()
	{
		return transform.n24;
	}

	public void setY( double value )
	{
		transform.n24 = value;
	}


	/**
	* An Number that sets the Z coordinate of a object relative to the origin of its parent.
	*/
	public Double getZ()
	{
		return transform.n34;
	}

	public void setZ( double value )
	{
		transform.n34 = value;
	}
	
	/**
	* Translate the display object in the direction it is facing, i.e. it's positive Z axis.
	*
	* @param	distance	The distance that the object should move forward.
	*/
	public void moveForward  ( double distance ) { translate( distance, FORWARD  ); }

	/**
	* Translate the display object in the opposite direction it is facing, i.e. it's negative Z axis.
	*
	* @param	distance	The distance that the object should move backward.
	*/
	public void moveBackward ( double distance ) { translate( distance, BACKWARD ); }

	/**
	* Translate the display object lateraly, to the left of the direction it is facing, i.e. it's negative X axis.
	*
	* @param	distance	The distance that the object should move left.
	*/
	public void moveLeft     ( double distance ) { translate( distance, LEFT     ); }

	/**
	* Translate the display object lateraly, to the right of the direction it is facing, i.e. it's positive X axis.
	*
	* @param	distance	The distance that the object should move right.
	*/
	public void moveRight    ( double distance ) { translate( distance, RIGHT    ); }

	/**
	* Translate the display object upwards, with respect to the direction it is facing, i.e. it's positive Y axis.
	*
	* @param	distance	The distance that the object should move up.
	*/
	public void moveUp       ( double distance ) { translate( distance, UP       ); }

	/**
	* Translate the display object downwards, with respect to the direction it is facing, i.e. it's negative Y axis.
	*
	* @param	distance	The distance that the object should move down.
	*/
	public void moveDown     ( double distance ) { translate( distance, DOWN     ); }

	/**
	* Move the object along a given direction.
	*
	* @param	distance	The distance that the object should travel.
	* @param	axis		The direction that the object should move towards.
	*/
	public void translate( double distance, Vector3D axis )
	{
		Vector3D vector = axis.copy();

		Matrix3D.rotateAxis( transform, vector );

		setX( getX() + distance * vector.x );
		setY( getY() + distance * vector.y );
		setZ( getZ() + distance * vector.z );
	}
	
	/**
	* Rotate the display object around its lateral or transverse axis �an axis running from the pilot's left to right in piloted aircraft, and parallel to the wings of a winged aircraft; thus the nose pitches up and the tail down, or vice-versa.
	*
	* @param	angle	The angle to rotate.
	*/
	public void pitch( double angle )
	{
		angle = angle * toRADIANS;

		Vector3D vector = RIGHT.copy();

		Matrix3D.rotateAxis( transform, vector );
		Matrix3D m = Matrix3D.rotationMatrix( vector.x, vector.y, vector.z, angle );
		
//		this.transform.copy3x3( Matrix3D.multiply3x3( m ,transform ) );
		transform.calculateMultiply3x3( m , transform );
	}


	/**
	* Rotate the display object around about the vertical axis �an axis drawn from top to bottom.
	*
	* @param	angle	The angle to rotate.
	*/
	public void yaw( double angle )
	{
		angle *= toRADIANS;

		Vector3D vector = UP.copy();

		Matrix3D.rotateAxis( transform, vector );
		Matrix3D m = Matrix3D.rotationMatrix( vector.x, vector.y, vector.z, angle );

		transform.calculateMultiply3x3( m , transform );
	}


	/**
	* Rotate the display object around the longitudinal axis �an axis drawn through the body of the vehicle from tail to nose in the normal direction of flight, or the direction the object is facing.
	*
	* @param	angle
	*/
	public void roll( double angle )
	{
		angle *= toRADIANS;

		Vector3D vector = FORWARD.copy();

		Matrix3D.rotateAxis( transform, vector );
		Matrix3D m = Matrix3D.rotationMatrix( vector.x, vector.y, vector.z, angle );

		transform.calculateMultiply3x3( m , transform );
	}
}
