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
package com.paperworld.rpc.input {
	import com.paperworld.rpc.data.AvatarInput;
	import com.paperworld.rpc.data.AvatarState;	

	/**
	 * <p><code>Move</code> stores the state of the player's avatar at a given time.</p>
	 * 
	 * @author Trevor
	 */
	public class Move 
	{
		/**
		 * integer time
		 */
		public var time : int;

		/**
		 * Character state.
		 */
		public var state : AvatarState;

		/**
		 * Character input
		 */			
		public var input : AvatarInput;

		/**
		 * Move data.
		 * 
		 * @author Trevor
		 */
		public function Move() 
		{
		}
		
		public function destroy():void 
		{
			time = 0;
			
			state.destroy();
			state = null;
			
			input.destroy();
			input = null;	
		}
	}
}
