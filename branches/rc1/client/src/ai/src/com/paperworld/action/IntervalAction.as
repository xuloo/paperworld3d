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
package com.paperworld.action 
{
	import com.paperworld.action.Action;
	
	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class IntervalAction extends Action 
	{
		/**
		 * The interval between actions.
		 */
		public var interval : int = 0;

		/**
		 * The time at which last act() occured.
		 */
		protected var lastinterpolationTime : int = 0;

		/**
		 * Current time.
		 */
		public var time : int = 0;
		
		/**
		 * Checks to see if enough time has passed since last action.
		 */
		override public function get canAct():Boolean
		{
			if (lastinterpolationTime + interval > time)
			{
				lastinterpolationTime = time;
				return true;	
			}	
			
			return false;
		}
	}
}
