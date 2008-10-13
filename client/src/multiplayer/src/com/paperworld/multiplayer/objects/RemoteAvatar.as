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
	import com.paperworld.input.Input;
	import com.paperworld.multiplayer.events.ServerSyncEvent;
	import com.paperworld.multiplayer.objects.Avatar;	

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class RemoteAvatar extends Avatar 
	{
		//private var logger : XrayLog = new XrayLog();

		public function RemoteAvatar()
		{
			super( );
		}

		override public function synchronise(event : ServerSyncEvent) : void
		{
			//proxy.synchronise(event.data.t, event.data.state, event.data.input);
			//super.synchronise( event );

			client.input = event.input.clone( );
	
			// correct if significantly different	
			if (client.state.compare( event.state ))
			{
				client.snap( event.state );
				client.smooth( );
			}
		}
	}
}
