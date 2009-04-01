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
package com.paperworld.flash.player 
{
	import com.actionengine.flash.core.EventDispatchingBaseClass;
	import com.actionengine.flash.util.logging.Logger;
	import com.actionengine.flash.util.logging.LoggerContext;
	import com.paperworld.api.ISynchronisedAvatar;		

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class Player extends EventDispatchingBaseClass 
	{
		private var logger : Logger = LoggerContext.getLogger( Player );

		protected var _avatar : ISynchronisedAvatar;		

		public function getAvatar() : ISynchronisedAvatar
		{
			return _avatar;	
		}

		public function setAvatar(avatar : ISynchronisedAvatar) : void
		{
			_avatar = avatar;	
		}

		public var username : String = "user";		

		public function Player()
		{
			super( this );
		}

		override public function initialise(...args) : void
		{
			//_avatar = new Avatar( );
		}
	}
}
