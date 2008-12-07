package com.paperworld.views 
{
	import org.papervision3d.materials.BitmapMaterial;	

	import flash.display.Bitmap;	

	import org.papervision3d.objects.DisplayObject3D;	
	import org.papervision3d.core.view.IView;
	import org.papervision3d.materials.ColorMaterial;
	import org.papervision3d.objects.primitives.Plane;
	import org.papervision3d.view.BasicView;

	import com.actionengine.flash.core.interfaces.IInitialisable;
	import com.paperworld.multiplayer.scenes.AbstractSynchronisedScene;

	import org.papervision3d.core.proto.MaterialObject3D;		

	/**
	 * @author Trevor
	 */
	public class ChequerBoardView extends BasicView implements IView, IInitialisable 
	{

		[Embed(source="Chequer.png")] 
		private var ChequerImage : Class; 

		public var syncScene : AbstractSynchronisedScene;

		public var floor : DisplayObject3D;

		private var $width : Number;

		private var $height : Number;

		public function ChequerBoardView(width : Number = 1000, height : Number = 1000, viewportWidth : Number = 640, viewportHeight : Number = 480, scaleToStage : Boolean = true, interactive : Boolean = false, cameraType : String = "Free") 
		{
			super( viewportWidth, viewportHeight, scaleToStage, interactive, cameraType );		
			
			$width = width;
			$height = height;	
		}

		public function initialise() : void 
		{
			initialiseFloor( );
			initialiseCamera( );
		}

		protected function initialiseFloor() : void 
		{
			var chequer : Bitmap = new ChequerImage( );
			var chequerWidth : Number = chequer.width;
			var chequerHeight : Number = chequer.height;
			
			var material : BitmapMaterial = new BitmapMaterial( chequer.bitmapData );
			material.tiled = true;
			material.maxU = $width / chequerWidth;
			material.maxV = $height / chequerHeight;
			
			floor = new Plane( material, 500, 500, 4, 4 );
			floor.pitch( 90 );
			
			scene.addChild( floor );
		}

		protected function initialiseCamera() : void 
		{
			camera.moveUp( 500 );
			camera.lookAt( floor );
		}
	}
}
