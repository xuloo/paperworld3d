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
package com.paperworld.multiplayer.events 
{
	import flash.events.Event;
	
	import com.actionengine.flash.input.Input;
	import com.paperworld.multiplayer.data.State;	

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class ServerSyncEvent extends Event 
	{
		public static var REMOTE_AVATAR_SYNC : String = "RemoteAvatarSync";
		public static var LOCAL_AVATAR_SYNC : String = "LocalAvatarSync";
		
		public static var SERVER_TIME_UPDATE : String = "ServerTimeUpdate";

		public static var AVATAR_DELETE : String = "AvatarDelete";

		public static var INPUT_RESPONSE : String = "InputResponse";

		public var id : String;

		public var time : int;

		public var input : Input;

		public var state : State;

		public function ServerSyncEvent(type : String, id : String, time : int = 0, input : Input = null, state : State = null, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super( type, bubbles, cancelable );
			
			this.id = id;
			this.time = time;
			this.input = input;
			this.state = state;
		}	
	}
}
