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

	/**
	 * <p><code>KinematicInput</code> Contains all the information about a user's input during a 'tick' of the game clock. 
	 * Maps the user input data to specific actions on the player's character.</p>
	 * 
	 * <p>This object is sent 'over the wire' to the server - so the server doesn't need to know anything about
	 * how this data was gathered (what input device was used) - only the effect it has on the character.</p>
	 * 
	 * @author Trevor
	 */
	public class AvatarInput
	{
		public var left : Boolean = false;

		public var right : Boolean = false;

		public var forward : Boolean = false;

		public var back : Boolean = false;

		public var up : Boolean = false;

		public var down : Boolean = false;

		public var yawNegative : Boolean = false;

		public var yawPositive : Boolean = false;        

		public var pitchNegative : Boolean = false;

		public var pitchPositive : Boolean = false;        

		public var rollNegative : Boolean = false;

		public var rollPositive : Boolean = false;

		public var mouseX : Number = 0.0;

		public var mouseY : Number = 0.0;

		public var firing : Boolean = false;

		/**
		 * Returns a new copy of this object.
		 */
		public function copy() : AvatarInput
		{
			var input : AvatarInput = new AvatarInput( );
			input.left = left;
			input.right = right;
			input.forward = forward;
			input.back = back;
			input.up = up;
			input.down = down;
			input.yawNegative = yawNegative;
			input.yawPositive = yawPositive;
			input.pitchNegative = pitchNegative;
			input.pitchPositive = pitchPositive;
			input.rollNegative = rollNegative;
			input.rollPositive = rollPositive;
			input.mouseX = mouseX;
			input.mouseY = mouseY;
			
			input.firing = firing;

			return input;
		}
		
		public function destroy():void 
		{
			left = false;
			right = false;	
			forward = false;	
			back = false;	
			up = false;	
			down = false;	
			yawNegative = false;	
			yawPositive = false;
			pitchNegative = false;	
			pitchPositive = false;
			rollNegative = false;
			rollPositive = false;
			mouseX = 0.0;
			mouseY = 0.0;
			firing = false;	
		}
	}
}
