package com.paperworld3d.controls.flex
{
	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.cameras.FollowCamera3D;
	import com.paperworld.rpc.player.RemotePlayer;
	import com.paperworld.rpc.scenes.RemoteScene;
	import com.paperworld.rpc.views.RemoteView;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
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
		
		[Bindable]
		private var _remoteView:RemoteView;
		
		private var _zone:String;
		
		private var _autoRender:String;
		
		public function set autoRender(value:String):void 
		{
			_autoRender = value;
		}
		
		private var _autoConnect:String;
		
		public function set autoConnect(value:String):void 
		{
			_autoConnect = value;
		}
		
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
		
		public function get zone():String 
		{
			return _zone;
		}
		
		[Inspectable]
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
		
		override protected function keyDownHandler (event: KeyboardEvent): void
		{
			super.keyDownHandler(event);
			//if (event.keyCode == Keyboard.ENTER) loginUser();
			logger.info("key down");
		}	
		
		override protected function keyUpHandler(event:KeyboardEvent):void
		{
			super.keyUpHandler(event);
			
			logger.info("key up");
		}
		
		private function onCreationComplete(event:FlexEvent) : void {
			logger.info("_zone: " + _zone);
			_remoteView = new RemoteView(_zone, width, height, false, true);
			
			var bootStrapper:Red5BootStrapper = Red5BootStrapper.getInstance();
			bootStrapper.addEventListener("bootStrapComplete", onBootStrapComplete);
			bootStrapper.addEventListener(Red5Event.CONNECTED, onConnected);
			//_remoteView.remoteScene.addEventListener("bootStrapComplete", onBootStrapComplete);
			//_remoteView.remoteScene.addEventListener(Red5Event.CONNECTED, onConnected);
			
			logger.info("View: " + _remoteView + ", " + _autoRender);
			addChild(_remoteView);
			
			if (_autoConnect == "true")
				connect();
		} 
		
		private function onBootStrapComplete(event:Event):void
		{
			logger.info("RemoteCanvas boot");
			
			_remoteView.remoteScene.connect();
			
			dispatchEvent(event);
		}
		
		private function onConnected(event:Red5Event):void 
		{
			logger.info("remote Canvas connected");
			
			if (_autoRender == "true")
				startRendering();
				
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
		
		public static const DEFAULT_HEIGHT:Number = 500;
		public static const DEFAULT_WIDTH:Number = 500;
		
		override protected function measure():void {
			super.measure();
			
			measuredHeight = measuredMinHeight = DEFAULT_HEIGHT;
			measuredWidth = measuredMinWidth = DEFAULT_WIDTH;
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			unscaledWidth = DEFAULT_WIDTH;
			unscaledHeight = DEFAULT_HEIGHT;
		}
	}
}