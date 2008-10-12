package  
{
	import com.paperworld.util.keys.KeyUpCommand;	
	import com.paperworld.util.keys.KeyboardManager;	

	import flash.events.Event;
	import flash.net.registerClassAlias;

	import org.papervision3d.core.proto.MaterialObject3D;
	import org.papervision3d.materials.WireframeMaterial;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.primitives.Plane;
	import org.papervision3d.view.BasicView;

	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.input.BasicKeyboardInput;
	import com.paperworld.input.Input;
	import com.paperworld.input.UserInput;
	import com.paperworld.multiplayer.behaviours.SimpleAvatarBehaviour2D;
	import com.paperworld.multiplayer.connectors.RTMPConnector;
	import com.paperworld.multiplayer.connectors.events.ConnectorEvent;
	import com.paperworld.multiplayer.data.State;
	import com.paperworld.multiplayer.data.SyncData;
	import com.paperworld.multiplayer.objects.SynchronisableObject;
	import com.paperworld.multiplayer.player.Player;
	import com.paperworld.multiplayer.scenes.SynchronisedScene;
	import com.paperworld.util.clock.Clock;
	import com.paperworld.util.clock.events.ClockEvent;
	import com.paperworld.util.math.Quaternion;
	import com.paperworld.util.math.Vector3;	

	/**
	 * @author Trevor
	 */
	public class AnimatedPapervisionDAEClient extends BasicView 
	{
		private var logger : XrayLog = new XrayLog( );

		private var syncScene : SynchronisedScene;

		private var player : Player;

		private var object : DisplayObject3D;

		public function AnimatedPapervisionDAEClient()
		{			
			logger.info( "HelloPaperWorldClient" );
			
			KeyboardManager.getInstance( ).addCommand( "a", "down", new KeyUpCommand( new BasicKeyboardInput( ) ) );
			
			var linkageEnforcer : LinkageEnforcer = new LinkageEnforcer( );
			
			var connector : RTMPConnector = new RTMPConnector( );
			connector.addEventListener( ConnectorEvent.CONTEXT_LOADED, onContextLoaded );
			connector.addEventListener( ConnectorEvent.CONNECTED_TO_SERVER, onConnectedToServer );
			
			var input : UserInput = new BasicKeyboardInput( );
			input.target = stage;
			
			connector.input = input;
			
			syncScene = new SynchronisedScene( );
			syncScene.connector = connector;
			
			//syncScene.addEventListener( SynchronisedSceneEvent.CONTEXT_LOADED, onContextLoaded );
			//syncScene.addEventListener( SynchronisedSceneEvent.CONNECTED_TO_SERVER, onConnectedToServer );
			syncScene.connect( "test" );
			
			player = new Player( );
			
			
			
			//var material : MaterialObject3D = new WireframeMaterial( 0xff0000 );
			//material.doubleSided = true;
			//var object : SynchronisableObject = new SynchronisableObject( new Plane( material, 100, 100 ) );
			//this.object = object.object;
			//syncScene.scene.addChild(object.object);
			
			
			
			
			//player.avatar.input = input.input;
			//player.avatar.syncObject = object;
			//player.avatar.behaviour = new SimpleAvatarBehaviour2D( );
			
			//syncScene.addRemoteChild( object );

			scene = syncScene.scene;
			
			registerClassAlias( 'com.paperworld.multiplayer.data.Input', Input );
			registerClassAlias( 'com.paperworld.multiplayer.data.SyncData', SyncData );
			registerClassAlias( 'com.paperworld.multiplayer.data.State', State );
			registerClassAlias( 'com.paperworld.core.math.Vector3', Vector3 );
			registerClassAlias( 'com.paperworld.core.math.Quaternion', Quaternion );
		}

		public function onContextLoaded(event : Event) : void 
		{
			logger.info( "Context Loaded connecting" );
		}

		public function onConnectedToServer(event : Event) : void
		{
			logger.info( "Connected To Server" );
						
			syncScene.addPlayer( player );
						
			var clock : Clock = Clock.getInstance( );
						
			clock.addEventListener( ClockEvent.RENDER, onRenderTick );
	
			clock.start( );
		}
	}
}

