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
	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.rpc.data.AvatarInput;
	import com.paperworld.rpc.data.AvatarState;
	import com.paperworld.rpc.smoothers.AbstractSmoother;
	import com.paperworld.rpc.smoothers.ISmoother;
	
	import flash.events.EventDispatcher;
	
	import jedai.Red5BootStrapper;
	
	import org.papervision3d.objects.DisplayObject3D;	

	/**
	 * Kinematic.
	 * The base of class for all objects that occupy PaperWorld. Provides minimal set of methods and properties for existing in the world,
	 * being visible and being able to interact with the player and/or the server.
	 */
	public class RemoteObject extends EventDispatcher
	{
		protected const defaultTightness : Number = 0.1;

		protected const smoothTightness : Number = 0.1;

		public var input : AvatarInput;

		public var state : AvatarState;

		public var time : int = 0;		

		public var replaying : Boolean = false;

		public var tightness : Number;
		
		private var _smoother:AbstractSmoother;
		
		public function get smoother():AbstractSmoother
		{
			return _smoother;
		}
		
		public function set smoother(value:AbstractSmoother):void 
		{
			_smoother = value;
		}

		//public var avatarBehaviour : IAvatarBehaviour;
		
		public var logger:XrayLog = new XrayLog();

		public var displayObject : DisplayObject3D;

		public function get current() : AvatarState
		{
			return state;	
		}
		
		public function setState(value:AvatarState):void 
		{
			this.state = value.copy( );
			displayObject.transform.copy( state.transform );
		}

		public function RemoteObject( displayObject : DisplayObject3D = null)	
		{
			super( );
			
			input = new AvatarInput( );
			state = new AvatarState( );
			
			//_smoother = Red5BootStrapper.getInstance().getObject("smoother") as AbstractSmoother;
			//_smoother.target = this;
			
			tightness = defaultTightness;

			this.displayObject = displayObject;
		}
		
		public function destroy():void 
		{					
			time = 0;	
			replaying = false;	
			tightness = 0;
			displayObject = null;
			
			input.destroy();
			input = null;
				
			state.destroy();
			state = null;
		}

		public function update(t : int, behaviour : IAvatarBehaviour) : void 
		{	
			behaviour.update( input, state, displayObject );		
            
			// update smoothing tightness value for adaptive smoothing	
			tightness += ( defaultTightness - tightness ) * 0.01;

			time++;
		}

		public function synchronise(t : int, state : AvatarState, input : AvatarInput) : void 
		{
			tightness = smoothTightness;
		}

		public function smooth(to : RemoteObject, tightness : Number) : void 
		{
			_smoother.smooth(current, to.current, tightness);
			
			
			
			/*var previous : AvatarState = current.copy( );
						
			current.orientation = Quaternion.slerp( previous.orientation, to.current.orientation, tightness );
        	
			var matrix : Matrix3D = Matrix3D.quaternion2matrix( current.orientation.x, current.orientation.y, current.orientation.z, current.orientation.w );
        	
			matrix.n14 = previous.transform.n14 + (to.current.transform.n14 - previous.transform.n14) * tightness;
			matrix.n24 = previous.transform.n24 + (to.current.transform.n24 - previous.transform.n24) * tightness;
			matrix.n34 = previous.transform.n34 + (to.current.transform.n34 - previous.transform.n34) * tightness;
        	
			current.transform = matrix;
			displayObject.transform.copy( matrix );*/
		}
	}
}