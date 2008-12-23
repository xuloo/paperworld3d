package com.paperworld.away3d.scenes 
{
	import com.paperworld.flash.scenes.AbstractSynchronisedScene;

	import away3d.containers.Scene3D;		

	/**
	 * @author Trevor
	 */
	public class SynchronisableAway3DScene extends AbstractSynchronisedScene
	{		
		public function SynchronisableAway3DScene(init : Object = null, ...args)
		{
			super( );
			
			scene = new Scene3D( init, args );
		}

		override public function addChild(child : *) : *
		{
			return scene.addChild( child );	
		}

		override public function removeChild(child : *) : *
		{
			return scene.removeChild( child );
		}
	}
}
