package  
{
	import flash.events.Event;
	
	import org.papervision3d.view.BasicView;
	
	import com.actionengine.flash.core.context.CoreContext;
	import com.actionengine.flash.input.BasicKeyboardInput;
	import com.actionengine.flash.input.UserInput;
	import com.actionengine.flash.util.clock.Clock;
	import com.actionengine.flash.util.clock.events.ClockEvent;
	import com.actionengine.flash.util.logging.Logger;
	import com.actionengine.flash.util.logging.LoggerContext;
	import com.paperworld.multiplayer.connectors.RTMPConnector;
	import com.paperworld.multiplayer.connectors.events.ConnectorEvent;
	import com.paperworld.multiplayer.player.Player;
	import com.paperworld.multiplayer.scenes.SynchronisedScene;	

	/**
	 * @author Trevor
	 */
	public class HelloPaperWorldClientPV3D extends BasicView 
	{
		private var logger : Logger;

		private var syncScene : SynchronisedScene;

		private var player : Player;

		public function HelloPaperWorldClientPV3D()
		{			
			var linkageEnforcer : LinkageEnforcer = new LinkageEnforcer( );
			
			var context : CoreContext = CoreContext.getInstance( );
			
			context.addContexts( [ 'logging-context.xml' ] );
			context.addEventListener( Event.COMPLETE, onContextLoaded );
			context.load( );			
		}

		private function onContextLoaded(event : Event) : void 
		{
			logger = LoggerContext.getLogger( HelloPaperWorldClientPV3D );
			
			var connector : RTMPConnector = new RTMPConnector( );
			connector.addEventListener( ConnectorEvent.CONNECTED_TO_SERVER, onConnectedToServer );
			
			var input : UserInput = new BasicKeyboardInput( );
			input.target = stage;
			
			connector.input = input;
			
			syncScene = new SynchronisedScene( );
			syncScene.connector = connector;
			syncScene.connect( "test" );
			
			player = new Player( );

			scene = syncScene.scene;
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