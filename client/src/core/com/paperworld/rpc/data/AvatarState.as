/*
 * --------------------------------------------------------------------------------------
 * PaperWorld3D - building better worlds
 * --------------------------------------------------------------------------------------
 * Realtime 3D Multi-User Application Framework for the Flash Platform.
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
 * --------------------------------------------------------------------------------------
 */
package com.paperworld.rpc.data 
{
	import org.papervision3d.core.math.Matrix3D;
	import org.papervision3d.core.math.Number3D;
	import org.papervision3d.core.math.Quaternion;	

	/**
	 * <p><code>AvatarState</code> holds the data about the current state of a <code>RemoteObject</code></p>
	 * 
	 * @author Trevor
	 */
	public class AvatarState
	{
		/**
		 * The transformation matrix that holds position and orientation data.
		 */
		public var transform : Matrix3D;

		/**
		 * Quaternion that holds only the orientation of the object. This property duplicates 
		 * the transform matrix's orientation in order to allow a SLERP calculation for smoothing.
		 */
		public var orientation : Quaternion;
		
		/**
		 * Rotation is a scalar amount. If the avatars in your application are restricted to movement across 
		 * a 2D plane (as they might be in, say, an FPS or Racing game) then you can use this value
		 * rather than a full Quaternion for smoothing orientation. The orientation of the character is 
		 * still calculated from the Quaternion value so you can always add a bit of pitch or roll later 
		 * for realism, but this rotation value is what comes back from the server, so it's quicker to calculate
		 * a view vector.
		 */
		public var rotation:Number;

		public var position : Number3D;

		/**
		 * The current speed of the object.
		 */
		public var speed : Number;

		/**
		 * Constructor.
		 */
		public function AvatarState()
		{
			transform = new Matrix3D( );
			orientation = new Quaternion( );
			position = new Number3D( );
			speed = 0;
			rotation = 0;
		}
		
		public function destroy():void 
		{
			transform = null;
			orientation = null;
			position = null;
			speed = 0;	
		}

		/**
		 * Returns a fresh copy of this <code>AvatarState</code> object.
		 */
		public function copy() : AvatarState
		{
			var state : AvatarState = new AvatarState( );
			state.transform.copy( transform );
			state.orientation = Quaternion.createFromMatrix( transform );
			state.position = new Number3D( transform.n14, transform.n24, transform.n34 );
			state.speed = speed;
			state.rotation = rotation;
        	
			return state;
		}

		/**
		 * Returns true if this object is identical to the object passed.
		 */
		public function equals( other : AvatarState ) : Boolean
		{
			/*return  position.x == other.position.x &&
			position.y == other.position.y &&
			position.z == other.position.z;*/
			return false;
		}

		/**
		 * Returns false if this object is identical to the object passed.
		 */
		public function notEquals( other : AvatarState ) : Boolean
		{
			return !( this.equals( other ) );
		}

		/**
		 * Returns true if the 'length' of the orientation and position values stored in this object
		 * are greater than the threshold value.
		 */
		public function compare(other : AvatarState) : Boolean
		{
			var threshold : Number = 0.1 * 0.1;

			return false;//(Number3D.sub( other.position, position )).lengthSquared( ) > threshold || (Quaternion.sub( other.orientation, orientation )).norm( ) > threshold;
		}

		/**
		 * Returns an <code>AvatarState</code> object that is the result of subtracting
		 * the position and orientation values of this and the object passed.
		 */
		public function returnSubtraction(other : AvatarState) : AvatarState
		{
			var state : AvatarState = new AvatarState( );
        	
			state.position = Number3D.sub( position, other.position );
			state.orientation = Quaternion.sub( orientation, other.orientation );
        	
			return state;	
		}

		/**
		 * Adds the position and orientation values of the passed object to this object.
		 */
		public function add(other : AvatarState) : void 
		{
			position = Number3D.add( other.position, position );
			orientation = Quaternion.add( other.orientation, orientation );	
		}

		/**
		 * Subtracts the position and orientation values of the passed object to this object.
		 */
		public function sub(other : AvatarState) : void 
		{
			position = Number3D.sub( other.position, position );
			orientation = Quaternion.sub( other.orientation, orientation );
		}

		/**
		 * toString() implementation.
		 */
		public function toString() : String 
		{
			return "\nTransform: " + transform + "\nOrientation: " + orientation + "\nPosition: " + position;	
		}
	}
}
