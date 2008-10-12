package com.paperworld.multiplayer.scenes 
{
	import away3d.containers.Scene3D;	

	/**
	 * @author Trevor
	 */
	public class SynchronisableAway3DScene extends AbstractSynchronisedScene
	{
		protected var _scene : Scene3D;

		public function SynchronisableAway3DScene(init : Object = null, ...args)
		{
			super( );
			
			_scene = new Scene3D(init, args);
		}

		override public function addChild(child : *) : *
		{
			return _scene.addChild( child );	
		}

		override public function removeChild(child : *) : *
		{
			return _scene.removeChild( child );
		}
	}
}
