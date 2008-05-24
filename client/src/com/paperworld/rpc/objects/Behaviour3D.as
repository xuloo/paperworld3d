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
package com.paperworld.rpc.objects
{
	import com.paperworld.rpc.objects.IAvatarBehaviour;	
	
	import org.papervision3d.core.math.Matrix3D;
	import org.papervision3d.core.math.Quaternion;
	import org.papervision3d.objects.DisplayObject3D;

	import com.paperworld.rpc.data.AvatarInput;
	import com.paperworld.rpc.data.AvatarState;	

	/**
	 * @author Trevor
	 */
	public class Behaviour3D implements IAvatarBehaviour
	{
		public var maxAcceleration : Number = 5

		public var maxSpeed : Number = 50;

		public var minSpeed : Number = -maxSpeed;

		public function Behaviour3D()
		{
		}
		
		public function destroy():void 
		{
			maxAcceleration = 0;
			maxSpeed = 0;
			minSpeed = 0;	
		}

		public function update(input : AvatarInput, state : AvatarState, displayObject : DisplayObject3D) : void 
		{			
			if ( input.forward ) 
				state.speed = state.speed + maxAcceleration > maxSpeed ? maxSpeed : state.speed + maxAcceleration;

			if ( input.back ) 
				state.speed = state.speed - maxAcceleration < minSpeed ? minSpeed : state.speed - maxAcceleration;
		
			displayObject.moveForward( state.speed );
			
			displayObject.pitch( input.mouseY );
			displayObject.yaw( input.mouseX );
			displayObject.roll( -input.mouseX );
			
			state.transform.copy( displayObject.transform );
			state.orientation = Quaternion.createFromMatrix( state.transform );
		}
	}
}
