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
package com.paperworld.flash.behaviours 
{
	import com.actionengine.flash.util.logging.Logger;
	import com.actionengine.flash.util.logging.LoggerContext;
	import com.brainfarm.flash.steering.SteeringBehaviour;
	import com.brainfarm.flash.steering.SteeringOutput;
	import com.brainfarm.flash.util.math.Vector3;
	import com.paperworld.flash.data.State;	

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class SimpleAvatarBehaviour2D extends SteeringBehaviour 
	{
		private var logger : Logger = LoggerContext.getLogger( SimpleAvatarBehaviour2D );

		public var moveForwardAmount : Number = 1;

		public var moveBackAmount : Number = 1;

		public var moveRightAmount : Number = 1;

		public var moveLeftAmount : Number = 1;

		public var turnLeftAmount : Number = 1;

		public var turnRightAmount : Number = 1;

		override public function getSteering(output : SteeringOutput) : void
		{
			output.clear();
			
			if (input != null) 
			{
				if (input.getForward( ))
					output.linear.z += moveForwardAmount;

				if (input.getBack( ))
					output.linear.z -= moveBackAmount;

				if (input.getMoveRight( ))
					output.linear.x += moveRightAmount;

				if (input.getMoveLeft( ))
					output.linear.x -= moveLeftAmount;

				if (input.getTurnRight( ))
					output.angular.w += turnRightAmount;

				if (input.getTurnLeft( ))
					output.angular.w -= turnLeftAmount;
			}
		}

		protected function handleForward(state : State) : Vector3 
		{
			return new Vector3( Math.cos( state.orientation.w ) * 5, 0, Math.sin( state.orientation.w ) * 5 );
		}
	}
}
