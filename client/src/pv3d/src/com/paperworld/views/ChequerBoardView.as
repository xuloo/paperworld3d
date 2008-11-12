package com.paperworld.views 
{
	import org.papervision3d.objects.primitives.Plane;	
	import org.papervision3d.core.view.IView;
	import org.papervision3d.view.BasicView;
	import org.papervision3d.view.AbstractView;	

	/**
	 * @author Trevor
	 */
	public class ChequerBoardView extends BasicView implements IView 
	{
		public function ChequerBoardView(viewportWidth : Number = 640, viewportHeight : Number = 480, scaleToStage : Boolean = true, interactive : Boolean = false, cameraType : String = "Debug") 
		{
			super( viewportWidth, viewportHeight, scaleToStage, interactive, cameraType );
			
			createFloor( );
		}

		protected function createFloor() : void 
		{
			var plane : Plane = new Plane( null, 500, 500, 4, 4 );
			scene.addChild( plane );
		}
	}
}
