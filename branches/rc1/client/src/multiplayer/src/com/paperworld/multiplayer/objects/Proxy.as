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
	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.input.Input;
	import com.paperworld.multiplayer.data.State;	

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class Proxy extends SyncObject 
	{
		protected var _lastSyncTime : int;

		public var updating : Boolean;

		private var logger : XrayLog = new XrayLog( );

		public function Proxy()
		{
			super();
		}

		override public function initialise() : void
		{
			super.initialise();
			
			_lastSyncTime = 0;
			updating = false;	
		}

		override public function synchronise(t : int, state : State, input : Input) : void
		{			
			if (t < _lastSyncTime)
            	return;

			_lastSyncTime = t;
			updating = true;
	
			// set proxy input	
			this.input = Input( input.clone( ) );
	
	        // correct if significantly different
	
	        /*if (state.compare(cube.state()))
	        {
	            cube.snap(state);
	            smooth();
	        }*/
		}

		override public function update(t : int) : void
		{
			if (updating)
          		super.update( t );
		}
	}
}
