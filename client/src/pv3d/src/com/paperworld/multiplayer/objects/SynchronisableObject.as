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
package com.paperworld.multiplayer.objects 
{
	import org.papervision3d.objects.DisplayObject3D;

	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.core.BaseClass;
	import com.paperworld.input.Input;
	import com.paperworld.multiplayer.data.State;
	import com.paperworld.util.Synchronizable;
	import com.paperworld.util.math.Quaternion;		

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class SynchronisableObject extends BaseClass implements Synchronizable 
	{
		public var object : DisplayObject3D;

		private var logger : XrayLog = new XrayLog( );

		public function SynchronisableObject(object : DisplayObject3D = null)
		{
			super( );
			
			this.object = object;
		}

		public function getObject() : *
		{
			return object;
		}

		public function synchronise(input : Input, state : State) : void
		{			
			this.object.x = state.position.x;
			this.object.y = state.position.y;
			this.object.z = state.position.z;

			object.localRotationY = state.orientation.w;
		}

		override public function destroy() : void
		{
		}
	}
}