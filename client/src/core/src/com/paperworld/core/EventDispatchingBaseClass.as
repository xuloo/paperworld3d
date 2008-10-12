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
package com.paperworld.core 
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	import com.paperworld.core.interfaces.*;	

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class EventDispatchingBaseClass extends EventDispatcher implements Destroyable, Initialisable
	{
		public function EventDispatchingBaseClass(target : IEventDispatcher = null)
		{
			super( target );
			
			initialise( );
		}

		public function destroy() : void
		{
		}

		public function initialise() : void
		{
		}
	}
}
