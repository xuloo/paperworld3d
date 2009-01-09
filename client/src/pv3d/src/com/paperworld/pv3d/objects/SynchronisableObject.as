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
package com.paperworld.pv3d.objects 
{
	import com.actionengine.flash.core.BaseClass;
	import com.actionengine.flash.input.Input;
	import com.actionengine.flash.util.logging.Logger;
	import com.actionengine.flash.util.logging.LoggerContext;
	import com.brainfarm.flash.data.State;
	import com.paperworld.api.ISynchronisedObject;
	
	import org.papervision3d.objects.DisplayObject3D;	

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class SynchronisableObject extends BaseClass implements ISynchronisedObject
	{
		private var logger : Logger = LoggerContext.getLogger( SynchronisableObject );

		public var object : DisplayObject3D;
		
		public function get displayObject() : *
		{
			return object;
		}
		
		public function set displayObject(value:*):void
		{
			object = value;
		}

		public function SynchronisableObject(object : DisplayObject3D = null)
		{
			super( );
			
			this.object = object;
		}

		public function getObject() : *
		{
			return object;
		}

		public function synchronise(time : int, input : Input, state : State) : void
		{						
			this.object.x += state.velocity.x;
			this.object.y += state.velocity.y;
			this.object.z += state.velocity.z;

			object.localRotationY = state.orientation.w;
		}

		override public function destroy() : void
		{
		}
		
		public function toString():String
		{
			return '[SynchronisedObject: ' + displayObject + ']';
		}
	}
}
