package com.paperworld.multiplayer.scenes 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import com.paperworld.multiplayer.objects.SimpleSynchronisableObject;
	import com.paperworld.multiplayer.scenes.AbstractSynchronisedScene;	

	/**
	 * @author Trevor
	 */
	public class SimpleSynchronisedScene extends AbstractSynchronisedScene 
	{
		protected var _scene : Sprite;

		public function get scene() : Sprite
		{
			return _scene;
		}

		public function set scene(value : Sprite) : void
		{
			_scene = value;
		}

		public function SimpleSynchronisedScene()
		{
			super( );
		}

		override public function initialise() : void
		{
			super.initialise( );
			
			_scene = new Sprite( );	
		}

		override public function addChild(child : *) : *
		{
			if (child is DisplayObject)
			{
				return _scene.addChild( child );	
			}
			else if (child is SimpleSynchronisableObject)
			{
				return _scene.addChild( SimpleSynchronisableObject( child ).object );
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
