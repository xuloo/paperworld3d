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
	import com.paperworld.core.interfaces.Initialisable;	
	import com.paperworld.core.interfaces.Destroyable;	
	
	/**
	 * The root of all paperworld classes. The BaseClass ensures that a class
	 * can be initialised and destroyed in a fixed manner.
	 * 
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class BaseClass implements Destroyable, Initialisable
	{
		/**
		 * Constructor. Calls the initialise method to ensure that instance properties
		 * are built in a consistent manner.
		 */
		public function BaseClass()
		{
			initialise( );	
		}

		/**
		 * Required implementation. Initialises instance properties.
		 */
		public function initialise() : void
		{
		}

		/**
		 * Required implementation. Breaks down instance properties to free up memory.
		 */
		public function destroy() : void
		{
		}
	}
}
