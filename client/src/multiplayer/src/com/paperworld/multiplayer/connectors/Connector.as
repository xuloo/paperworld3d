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
package com.paperworld.multiplayer.connectors 
{
	import com.paperworld.multiplayer.player.Player;	
	
	import flash.events.IEventDispatcher;

	import com.paperworld.input.UserInput;		

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public interface Connector extends IEventDispatcher
	{
		function connect(scene : String = null, context : String = null) : void;

		function disconnect() : void

		function set input(value : UserInput) : void;

		function get id() : String;
		
		function addPlayer(player : Player):void;

		function addListener(listener : ConnectorListener) : void;

		function removeListener(listener : ConnectorListener) : void;
	}
}
