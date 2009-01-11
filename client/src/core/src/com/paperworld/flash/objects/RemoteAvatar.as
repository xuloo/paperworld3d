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
package com.paperworld.flash.objects 
{
	import com.actionengine.flash.input.Input;
	import com.actionengine.flash.util.logging.Logger;
	import com.actionengine.flash.util.logging.LoggerContext;
	import com.brainfarm.flash.data.State;	

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class RemoteAvatar extends AbstractSynchronisedAvatar 
	{
		protected var _lastSyncTime : int;

		public var updating : Boolean;

		private var logger : Logger = LoggerContext.getLogger( RemoteAvatar );

		public function RemoteAvatar()
		{
			super( );
		}

		override public function initialise(...args) : void
		{
			super.initialise( );
			
			_lastSyncTime = 0;
			updating = false;	
		}

		override public function synchronise(time : int, input : Input, state : State) : void
		{			
			// Just ignore any out of order packets...
			if (time < _lastSyncTime)
            	return;		

			_lastSyncTime = time;
			updating = true;
	
			// set proxy input	
			_input = input.clone( );
	
			// correct if significantly different	
			if (state.compare( _current ))
			{
				snap( state );
				smooth( );				
			}
		}

		override public function update() : void
		{			
			if (updating)
			{				
				super.update( );
			}
		}
	}
}
