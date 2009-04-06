package com.paperworld.flash.pv3d.views
{
	import flash.utils.Dictionary;
	
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.view.AbstractView;
	import org.papervision3d.view.layer.ViewportLayer;

	public class BasicPaperworldView extends AbstractView
	{
		protected var layers:Dictionary;
		
		public function getLayerByName(name:String):ViewportLayer
		{
			return ViewportLayer(layers[name]);
		}
		
		public function BasicPaperworldView()
		{
			super();
			
			layers = new Dictionary(true);
		}
		
		public function createLayer(name:String, parent:String = null, do3d:DisplayObject3D = null):ViewportLayer
		{
			var d:DisplayObject3D = do3d ? do3d : new DisplayObject3D();
			var layer:ViewportLayer = viewport.getChildLayer(d, true);
			layers[name] = layer;
			return layer;
		}
	}
}