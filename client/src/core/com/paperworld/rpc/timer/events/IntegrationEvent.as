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
package com.paperworld.rpc.timer.events
{
	import flash.events.Event;
	
	import com.paperworld.rpc.input.IUserInput;	

	public class IntegrationEvent extends Event
	{
		// The current step time of the simulation.
		public var time : int;

		public var input : IUserInput;
		
		/**
		 * @private
		 */
		public static const INTEGRATION_EVENT : String = "IntegrationEvent";

		public function IntegrationEvent( time : int, input : IUserInput, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super( INTEGRATION_EVENT, bubbles, cancelable );
			
			this.time = time;
			this.input = input;
		}
	}
}