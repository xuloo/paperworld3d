package com.paperworld.flash.multiplayer.scenes 
{	
	import com.paperworld.flash.multiplayer.objects.SimpleSynchronisableObject;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;
		

	/**
	 * @author Trevor
	 */
	public class SimpleSynchronisedScene extends AbstractSynchronisedScene
	{
		private static var logger:ILogger = LoggerFactory.getLogger("Paperworld");

		protected var _view : Sprite;

		public function get view() : Sprite
		{
			return _view;
		}

		public function set view(value : Sprite) : void 
		{
			_view = value;
		}

		public function SimpleSynchronisedScene()
		{
			super( );
			
			initialise( );
		}

		override public function initialise() : void
		{			
			_view = new Sprite( );
			
			super.initialise( );
		}

		override public function addChild(child : *, name : String) : *
		{			
			if (child is DisplayObject)
			{
				return _view.addChild( DisplayObject( child ) );	
			}
			else if (child is SimpleSynchronisableObject)
			{
				logger.info( "adding child " + SimpleSynchronisableObject( child ).object );
				return _view.addChild( SimpleSynchronisableObject( child ).object );
			}
			else
			{
				// error - not a valid type.
			}
			
			return null;
		}

		override public function removeChild(child : *) : *
		{
			return _view.removeChild( child );
		}
	}
}
