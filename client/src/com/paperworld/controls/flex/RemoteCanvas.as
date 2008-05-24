package com.paperworld.controls.flex
{
	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.cameras.FollowCamera3D;
	import com.paperworld.rpc.player.RemotePlayer;
	import com.paperworld.rpc.scenes.RemoteScene;
	import com.paperworld.rpc.views.RemoteView;
	
	import flash.events.Event;
	
	import jedai.Red5BootStrapper;
	import jedai.events.Red5Event;
	import jedai.net.rpc.Red5Connection;
	
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	
	import org.papervision3d.cameras.*;
	import org.papervision3d.core.proto.CameraObject3D;
	import org.papervision3d.objects.DisplayObject3D;

	public class RemoteCanvas extends UIComponent
	{
		private var _bootStrapper:Red5BootStrapper;
		private var _connection:Red5Connection;
		
		private var logger:XrayLog = new XrayLog();
		
		private var _remoteView:RemoteView;
		
		private var _zone:String;
		
		public function get scene():RemoteScene
		{
			return _remoteView.remoteScene;
		}
		
		public function get camera():CameraObject3D
		{
			return _remoteView.camera;
		}
		
		public function get view():RemoteView
		{
			return _remoteView;
		}
		
		public function set zone(value:String):void 
		{
			logger.info("Setting zone");
			_zone = value;
			
			if (_remoteView)
				_remoteView.zone = value;
		}
		
		public function RemoteCanvas()
		{
			super();
			
			this.addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
		}
		
		private function onCreationComplete(event:FlexEvent) : void {
			logger.info("width: " + width);
			_remoteView = new RemoteView(_zone, width, height, false, true);
			_remoteView.remoteScene.addEventListener("bootStrapComplete", onBootStrapComplete);
			_remoteView.remoteScene.addEventListener(Red5Event.CONNECTED, onConnected);
			
			logger.info("View: " + _remoteView);
			addChild(_remoteView);
		} 
		
		private function onBootStrapComplete(event:Event):void
		{
			logger.info("RemoteCanvas boot");
			dispatchEvent(event);
		}
		
		private function onConnected(event:Red5Event):void 
		{
			logger.info("remote Canvas connected");
			dispatchEvent(event);
		}
			
		public function addChild3D(child:DisplayObject3D, name:String = null):DisplayObject3D
		{
			logger.info("scene: " + _remoteView);
			return _remoteView.remoteScene.addChild(child, name);
		}
		
		public function startRendering():void
		{			
			_remoteView.startRendering();
		}
		
		public function stopRendering(reRender:Boolean = false, cacheAsBitmap:Boolean = false):void
		{
			_remoteView.stopRendering(reRender, cacheAsBitmap);
		}
		
		public function singleRender():void 
		{
			_remoteView.singleRender();
		}
		
		public function get cameraAsCamera3D():Camera3D
		{
			return _remoteView.cameraAsCamera3D;
		}
		
		public function get cameraAsFreeCamera3D():FreeCamera3D
		{
			return _remoteView.cameraAsFreeCamera3D;
		}
		
		public function get cameraAsFrustrumCamera3D():FrustumCamera3D
		{
			return _remoteView.cameraAsFrustrumCamera3D
		}
		
		public function get cameraAsFollowCamera3D():FollowCamera3D
		{
			return _remoteView.cameraAsFollowCamera3D;
		}
		
		public function addPlayer(player:RemotePlayer):void
		{
			_remoteView.remoteScene.addPlayer(player);
		}
		
		public function connect():void 
		{
			_remoteView.remoteScene.connect();
		}
		
		public function get connection():Red5Connection
		{
			return _remoteView.connection;
		}
	}
}