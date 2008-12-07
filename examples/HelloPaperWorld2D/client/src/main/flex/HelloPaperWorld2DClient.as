package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import com.actionengine.flash.core.context.CoreContext;
	import com.actionengine.flash.input.BasicKeyboardInput;
	import com.actionengine.flash.input.UserInput;
	import com.actionengine.flash.util.clock.Clock;
	import com.actionengine.flash.util.logging.Logger;
	import com.actionengine.flash.util.logging.LoggerContext;
	import com.paperworld.flash.connectors.RTMPConnector;
	import com.paperworld.flash.connectors.events.ConnectorEvent;
	import com.paperworld.flash.player.Player;
	import com.paperworld.flash.scenes.SimpleSynchronisedScene;	

	/**
	 * @author Trevor
	 */
	public class HelloPaperWorld2DClient extends Sprite 
	{
		private var logger : Logger;

		private var syncScene : SimpleSynchronisedScene;

		private var player : Player;

		public function HelloPaperWorld2DClient()
		{
			var linkageEnforcer : LinkageEnforcer = new LinkageEnforcer( );
			
			var context : CoreContext = CoreContext.getInstance( );
			
			context.addContexts( [ 'logging-context.xml' ] );
			context.addEventListener( Event.COMPLETE, onContextLoaded );
			context.load( );				
		}

		private function onContextLoaded(event : Event) : void 
		{
			logger = LoggerContext.getLogger( HelloPaperWorld2DClient );
			
			logger.info( "Context Loaded connecting" );
			
			var connector : RTMPConnector = new RTMPConnector( );
			connector.addEventListener( ConnectorEvent.CONNECTED_TO_SERVER, onConnectedToServer );
			
			var input : UserInput = new BasicKeyboardInput( );
			input.target = stage;
			
			connector.input = input;
			
			syncScene = new SimpleSynchronisedScene( );
			syncScene.connector = connector;
			syncScene.connect( "HelloPaperWorld2D" );
			
			addChild( syncScene.view );
			
			player = new Player( );
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
