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
package com.paperworld.rpc.objects 
{
	import org.papervision3d.objects.DisplayObject3D;
	
	import com.paperworld.rpc.data.AvatarInput;
	import com.paperworld.rpc.data.AvatarState;
	import com.paperworld.rpc.objects.RemoteObject;	

	/**
	 * @author Trevor
	 */
	public class Proxy extends RemoteObject 
	{
		public var lastSyncTime : int = 0;

		public var updating : Boolean = false;
		
		public function Proxy(displayObject : DisplayObject3D = null)
		{
			super( displayObject || new DisplayObject3D( ) );			
		}
		
		override public function destroy():void 
		{
			lastSyncTime = 0;
			updating = false;
			
			super.destroy();
		}

		override public function synchronise(t : int, state : AvatarState, input : AvatarInput) : void
		{
			lastSyncTime = t;
			updating = true;

			this.input = input.copy( );			
			this.state = state.copy();
		}

		override public function update(t : int, behaviour : IAvatarBehaviour) : void
		{			
			if (updating)
	            super.update( t, behaviour );  
		}
	}
}
