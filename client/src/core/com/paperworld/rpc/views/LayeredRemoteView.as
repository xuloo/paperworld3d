package com.paperworld.rpc.views
{
	import com.paperworld.rpc.scenes.LayeredRemoteScene;
	
	import org.papervision3d.objects.DisplayObject3D;
		
	public class LayeredRemoteView extends RemoteView
	{
		public function get layeredScene():LayeredRemoteScene
		{
			return scene as LayeredRemoteScene;
		}
		
		public function LayeredRemoteView(zone:String=null, viewportWidth:Number=640, viewportHeight:Number=320, scaleToStage:Boolean=true, interactive:Boolean=true, cameraType:String="FREECAMERA3D")
		{
			super(zone, viewportWidth, viewportHeight, scaleToStage, interactive, cameraType);
		}
		
		override protected function createScene(scene:String=null):void
		{
			this.scene = new LayeredRemoteScene(scene);
		}
		
		public function addChildAtIndex(child:DisplayObject3D, index:int):DisplayObject3D
		{
			return null;
		}
	}
}