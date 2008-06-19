package com.paperworld.rpc.scenes
{
	import com.paperworld.rpc.objects.Avatar;

	public class LayeredRemoteScene extends RemoteScene
	{
		private var _layerPlayers:Boolean;
		
		public function LayeredRemoteScene(zone:String=null, autoConnect:Boolean=false, layerPlayers:Boolean = false)
		{
			super(zone, autoConnect);
			
			_layerPlayers = layerPlayers;
		}
		
		override protected function createPaperworldObject(key:String, name:String):Avatar
		{
			//var parentLayer:ViewportLayer = new ViewportLayer(viewport, null);
			//viewport.containerSprite.addLayer(parentLayer);
			
			return null;
		}
	}
}