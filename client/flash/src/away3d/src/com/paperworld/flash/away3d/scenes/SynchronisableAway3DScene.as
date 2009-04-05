package com.paperworld.flash.away3d.scenes 
{
	import away3d.containers.Scene3D;
	
	import com.paperworld.flash.multiplayer.scenes.AbstractSynchronisedScene;
	

	/**
	 * @author Trevor
	 */
	public class SynchronisableAway3DScene extends AbstractSynchronisedScene
	{		
		public function SynchronisableAway3DScene(init : Object = null, ...args)
		{
			super( );
			
			scene = new Scene3D( );
		}

		override public function addChild(child : *, name : String) : *
		{
			return scene.addChild( child );	
		}

		override public function removeChild(child : *) : *
		{
			return scene.removeChild( child );
		}
	}
}
