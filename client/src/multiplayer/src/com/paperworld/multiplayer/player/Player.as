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
package com.paperworld.multiplayer.player 
{
	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.core.EventDispatchingBaseClass;
	import com.paperworld.multiplayer.objects.Avatar;
	
	import jedai.net.rpc.Red5Connection;	

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class Player extends EventDispatchingBaseClass 
	{
		private var logger : XrayLog = new XrayLog( );		

		protected var _connection : Red5Connection;

		protected var _avatar : Avatar;		

		public function get avatar() : Avatar
		{
			return _avatar;	
		}

		public function set avatar(value : Avatar) : void
		{
			_avatar = value;	
		}

		public var username : String = "user";

		

		public function Player()
		{
			super( this );
		}

		override public function initialise() : void
		{
			//_avatar = new Avatar( );
		}
	}
}
