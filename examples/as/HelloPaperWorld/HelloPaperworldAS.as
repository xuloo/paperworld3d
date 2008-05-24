package {
	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.PaperWorld;
	import com.paperworld.rpc.player.RemotePlayer;
	import com.paperworld.rpc.scenes.RemoteScene;
	import com.paperworld.rpc.timer.GameTimer;
	import com.paperworld.rpc.timer.events.IntegrationEvent;
	import com.paperworld.rpc.views.RemoteView;
	
	import examples.SimpleAvatar;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.net.Responder;
	
	import jedai.Red5BootStrapper;
	import jedai.events.Red5Event;
	import jedai.net.rpc.Red5Connection;
	
	import org.papervision3d.cameras.FreeCamera3D;
	import org.papervision3d.events.FileLoadEvent;
	import org.papervision3d.materials.ColorMaterial;
	import org.papervision3d.objects.parsers.DAE;
	import org.papervision3d.objects.primitives.Plane;

	public class HelloPaperworldAS extends Sprite
	{
		private var _bootStrapper:Red5BootStrapper;
		
		private var _connection:Red5Connection;
		
		private var _remoteView:RemoteView;
		
		private var _remoteScene:RemoteScene;
		
		private var _player:RemotePlayer;
		
		private var _monster:DAE;
		
		private var logger:XrayLog = new XrayLog();
		
		public function HelloPaperworldAS()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
					
						
			PaperWorld.getInstance().initialise(stage);
	
			/*_monster = new DAE();
			_monster.addEventListener(FileLoadEvent.LOAD_COMPLETE, fileLoadComplete);
			_monster.load("monster.dae");*/
	
			_remoteView = new RemoteView("spacezone", 0, 0, true, false, FreeCamera3D.TYPE);
			_remoteView.cameraAsFreeCamera3D.y = 200;
			_remoteView.cameraAsFreeCamera3D.x = -250;
			addChild(_remoteView);		
			
			_remoteScene = _remoteView.remoteScene;
			_remoteScene.addEventListener("bootStrapComplete", onBootstrapComplete);
			_remoteScene.addEventListener(Red5Event.CONNECTED, onConnected);
			
			_remoteScene.connect();
			
			var floor:Plane = new Plane(new ColorMaterial(0x000000), 5000, 5000, 10, 10);
			floor.pitch(90);
			
			//_remoteScene.addChild(floor);	
		}
		
		private function fileLoadComplete(event:FileLoadEvent):void 
		{						
			/*var model:DisplayObject3D = _monster.getChildByName("COLLADA_Scene");
			model.scale = 10;
			model.pitch(120);
			model.roll(90);
			model.moveLeft(250);*/
			
			_remoteScene = _remoteView.remoteScene;
			_remoteScene.addEventListener("bootStrapComplete", onBootstrapComplete);
			_remoteScene.addEventListener(Red5Event.CONNECTED, onConnected);
			
			_remoteScene.connect();
			
			var floor:Plane = new Plane(new ColorMaterial(0x000000), 5000, 5000, 10, 10);
			floor.pitch(90);
			
			_remoteScene.addChild(floor);
		}
		
		public function createPlayer():RemotePlayer
		{
			var player:RemotePlayer = new RemotePlayer();
			player.avatar = new SimpleAvatar();
			
			return player;
		}
		
		private function onBootstrapComplete(event:Event):void 
		{
			logger.info("bootstrap complete");
			
			_player = createPlayer();
			_remoteScene.addPlayer(_player);
		}
				
		public function onConnected(event : Red5Event) : void 
		{
			_player.connection = _remoteScene.connection; 
			_connection = _remoteScene.connection;
			
			logger.info("remote Scene has connected - ready to set up app");
			_player.client = Red5BootStrapper.getInstance().client;
			logger.info("Red5 client: " + Red5BootStrapper.getInstance().client + " connection: " + _connection);
			
			_connection.call( "paperworld.connectToZone", new Responder( connectionHandler ), _player.username, "spacezone" );
			/*			
			_player = new RemotePlayer(_connection);
			_player.avatar = createAvatar();
			_player.avatar.behaviour = new Behaviour3D();
			_player.client = _bootStrapper.client;
						
			_connection.call( "paperworld.connectToZone", new Responder( connectionHandler ), _player.username, "spacezone" );
			
			_remoteView.getScene().createRoomSO();
			*/
			
		}
		
		private function connectionHandler(obj : Object) : void 
		{
			_player.avatar.name = _player.username;
			_remoteView.remoteScene.addChild(_player.avatar, _player.username);
			_remoteView.startRendering();
			
			GameTimer.getInstance().addEventListener(IntegrationEvent.INTEGRATION_EVENT, _player.avatar.update);
			GameTimer.getInstance().addEventListener(IntegrationEvent.INTEGRATION_EVENT, _player.handleInput);
		}
		
		
	}
}

/*
package {
	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.PaperWorld;
	import com.paperworld.rpc.objects.Avatar;
	import com.paperworld.rpc.objects.RemoteObject;
	import com.paperworld.rpc.player.Player;
	import com.paperworld.rpc.views.RemoteView;
	
	//import examples.SimpleAvatar;
	
	import flash.display.Sprite;
	
	import jedai.Red5BootStrapper;
	import jedai.net.rpc.Red5Connection;
	
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.primitives.Plane;
		
	public class HelloPaperWorldAS extends Sprite
	{		
		private static var logger:XrayLog = new XrayLog();
		
		private var bootStrapper:Red5BootStrapper;
		private var connection:Red5Connection;
		
		//private var avatar:Avatar;
		
		public function HelloPaperWorldAS()
		{
			//var simpleAvatar:SimpleAvatar = new SimpleAvatar();
						
			PaperWorld.getInstance().initialise(stage);
	
			var remoteView:RemoteView = new RemoteView();
			addChild(remoteView);
			
			var player:Player = new Player(remoteView.connection);
			
			remoteView.getScene().player = player;
			
			avatar = createAvatar();
			remoteView.scene.addChild(avatar);
			
			remoteView.startRendering();
		}		
		
		private function createAvatar():Avatar 
		{
			var avatar:Avatar = new Avatar();
			var model:DisplayObject3D = new Plane(null, 250, 250);
			avatar.avatar = new RemoteObject(model);
			
			avatar.addChild(model);
			
			return avatar;
		}
		
		public static function log(msg:String):void 
		{
			logger.info(msg);
		}
	}
}
*/
