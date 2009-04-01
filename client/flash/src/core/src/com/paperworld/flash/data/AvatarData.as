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
	import com.paperworld.api.ISynchronisedAvatar;
	import com.paperworld.flash.input.Input;	

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class AvatarData
	{
		public var id : String;

		public var key : String;

		public var time : int;

		public var input : Input;

		public var state : State;
		
		public function AvatarData(avatar : ISynchronisedAvatar = null)
		{
			super( );
		}

		public function getId() : String 
		{
			return id;
		}

		public function setId(id : String) : void 
		{
			this.id = id;
		}

		public function getKey() : String
		{
			return key;
		}

		public function setKey(key : String) : void
		{
			this.key = key;
		}

		public function getTime() : int
		{
			return time;
		}

		public function setTime(time : int) : void
		{
			this.time = time;
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
			return 'AvatarData {\n    id: ' + id + '\n    key: ' + key + '\n}';	
		}
	}
}