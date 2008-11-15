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
	import com.actionengine.flash.util.clock.events.ClockEvent;
	import com.actionengine.flash.util.logging.Logger;
	import com.actionengine.flash.util.logging.LoggerContext;
	import com.paperworld.multiplayer.data.State;
	import com.paperworld.multiplayer.events.ServerSyncEvent;		

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class Proxy extends SyncObject 
	{
		protected var _lastSyncTime : int;

		public var updating : Boolean;

		private var logger : Logger = LoggerContext.getLogger( Proxy );

		public function Proxy()
		{
			super( );
		}

		override public function initialise() : void
		{
			super.initialise( );
			
			_lastSyncTime = 0;
			updating = false;	
		}

		override public function synchronise(event : ServerSyncEvent) : void
		{			
			if (event.time < _lastSyncTime)
            	return;

			_lastSyncTime = event.time;
			updating = true;
	
			// set proxy input	
			this.input = event.input.clone( );
	
			// correct if significantly different	
			if (state.compare( this.state ))
			{
				snap( state );
				smooth( );
			}
		}

		override public function update(event : ClockEvent = null) : void
		{				
			if (updating)
			{
				super.update( event );
			}
		}
	}
}
