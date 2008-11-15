package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import com.actionengine.flash.input.BasicKeyboardInput;
	import com.actionengine.flash.input.UserInput;
	import com.actionengine.flash.util.clock.Clock;
	import com.actionengine.flash.util.logging.Logger;
	import com.actionengine.flash.util.logging.LoggerContext;
	import com.paperworld.multiplayer.connectors.RTMPConnector;
	import com.paperworld.multiplayer.connectors.events.ConnectorEvent;
	import com.paperworld.multiplayer.player.Player;
	import com.paperworld.multiplayer.scenes.SimpleSynchronisedScene;	

	/**
	 * @author Trevor
	 */
	public class HelloPaperWorld2DClient extends Sprite 
	{
		private var logger : Logger = LoggerContext.getLogger( HelloPaperWorld2DClient );

		private var syncScene : SimpleSynchronisedScene;

		private var player : Player;
		
		private var scene : Sprite;

		public function HelloPaperWorld2DClient()
		{
			var linkageEnforcer : LinkageEnforcer = new LinkageEnforcer( );
						
			var connector : RTMPConnector = new RTMPConnector( );
			connector.addEventListener( ConnectorEvent.CONTEXT_LOADED, onContextLoaded );
			connector.addEventListener( ConnectorEvent.CONNECTED_TO_SERVER, onConnectedToServer );
			
			var input : UserInput = new BasicKeyboardInput( );
			input.target = stage;
			
			connector.input = input;
			
			syncScene = new SimpleSynchronisedScene( );
			syncScene.connector = connector;
			syncScene.connect( "test" );
			
			player = new Player( );

			scene = syncScene.scene;
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
						
			//clock.addEventListener( ClockEvent.RENDER, onRenderTick );
	
			clock.start( );
		}
	}
}
