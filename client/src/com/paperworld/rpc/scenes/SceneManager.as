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
package com.paperworld.rpc.scenes
{
	import flash.utils.Dictionary;

	import org.papervision3d.core.proto.SceneObject3D;

	import com.blitzagency.xray.logger.XrayLog;	

	public class SceneManager
	{
		private static var $instance : SceneManager;

		private var $scenes : Dictionary;

		private var $logger : XrayLog = new XrayLog( );

		public function SceneManager()
		{
			$logger.info( "SceneManager created" )
			
			$scenes = new Dictionary( );
		}

		public static function getInstance() : SceneManager
		{
			if ($instance == null)
			{
				$instance = new SceneManager( )
			}
			
			return $instance;
		}

		public function addScene(key : String, scene : SceneObject3D) : Boolean
		{
			$logger.info( "Adding scene: " + scene )
			$scenes[key] = scene;
			
			return true;
		}

		public function getScene(key : String) : SceneObject3D
		{
			//$logger.info("getting scene: " + key + " => " + $scenes[key])
			return $scenes[key] as SceneObject3D;
		}
	}
}