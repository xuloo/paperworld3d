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
package com.paperworld.flash.pv3d.scenes 
{
	import com.paperworld.flash.multiplayer.scenes.AbstractSynchronisedScene;
	import com.paperworld.flash.pv3d.objects.SynchronisableObject;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.scenes.Scene3D;		

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class SynchronisedScene extends AbstractSynchronisedScene 
	{
		private var logger : ILogger = LoggerFactory.getLogger( "Paperworld(PV3D)" );

		protected var _scene : Scene3D;

		override public function get scene() : *
		{
			return _scene;
		}

		override public function set scene(value : *) : void
		{
			_scene = value;
		}

		public function SynchronisedScene(scene : Scene3D)
		{
			super( );
			
			_scene = scene;
		}

		override public function initialise() : void
		{
			super.initialise( );
			
			_scene = new Scene3D( );	
		}

		override public function addChild(child : *, name : String) : *
		{			
			logger.info( "adding " + SynchronisableObject( child ).object );
			
			if (child is DisplayObject3D)
			{
				return _scene.addChild( child, name );	
			}
			else if (child is SynchronisableObject)
			{
				return _scene.addChild( SynchronisableObject( child ).object, name );
			}
			else
			{
				// error - not a valid type.
			}
			
			return null;	
		}

		override public function removeChild(child : *) : *
		{
			return _scene.removeChild( child );
		}
	}
}
