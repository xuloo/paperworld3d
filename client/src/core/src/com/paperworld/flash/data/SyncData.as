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
package com.paperworld.flash.data 
{
	import com.actionengine.flash.input.Input;	

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class SyncData 
	{
		public var time : int;

		public var serverTime : int;

		public var input : Input;

		public var state : State;

		public function SyncData()
		{
			
		}

		public function getTime() : int
		{
			return time;
		}

		public function setTime(time : int) : void
		{
			this.time = time;
		}

		public function getServerTime() : int
		{
			return serverTime;
		}

		public function serServerTime(serverTime : int) : void
		{
			this.serverTime = serverTime;
		}

		public function getInput() : Input
		{
			return input;	
		}

		public function setInput(input : Input) : void
		{	
			this.input = input;
		}

		public function getState() : State
		{
			return state;	
		}

		public function setState(state : State) : void
		{
			this.state = state;	
		}

		public function toString() : String
		{
			return 'ServerSyncEvent {\n' + '    time: ' + time + '\n    input: ' + input + '\n    state: ' + state + '\n}';
		}
	}
}
