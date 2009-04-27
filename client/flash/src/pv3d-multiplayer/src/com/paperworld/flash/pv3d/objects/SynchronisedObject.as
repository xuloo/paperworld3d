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
package com.paperworld.flash.pv3d.objects 
{
	import com.paperworld.flash.api.multiplayer.ISynchronisedObject;
	import com.paperworld.flash.multiplayer.data.State;
	import com.paperworld.flash.util.input.IInput;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;
	import org.papervision3d.objects.DisplayObject3D;	

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class SynchronisedObject implements ISynchronisedObject
	{
		private var logger : ILogger = LoggerFactory.getLogger( "Paperworld(PV3D)" );

		private var _displayObject : DisplayObject3D;
		
		public function get displayObject() : *
		{
			return _displayObject;
		}
		
		public function set displayObject(value:*):void
		{
			_displayObject = value;
		}

		public function SynchronisedObject(displayObject : DisplayObject3D = null)
		{
			super( );
			
			_displayObject = displayObject;
		}

		public function synchronise(time : int, input : IInput, state : State) : void
		{												
			_displayObject.x = state.px;
			//_displayObject.y = state.py;
			//_displayObject.z = state.pz;

			//_displayObject.localRotationY = state.ow;
		}

		public function destroy() : void
		{
		}
		
		public function toString():String
		{
			return '[SynchronisedObject: ' + displayObject + ']';
		}
	}
}
