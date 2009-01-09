package  
{
	import com.actionengine.flash.core.context.CoreContext;
	import com.actionengine.flash.input.BasicKeyboardInput;
	import com.actionengine.flash.input.IUserInput;
	import com.actionengine.flash.util.clock.Clock;
	import com.actionengine.flash.util.clock.events.ClockEvent;
	import com.actionengine.flash.util.logging.Logger;
	import com.actionengine.flash.util.logging.LoggerContext;
	import com.paperworld.flash.connectors.RTMPConnector;
	import com.paperworld.flash.connectors.RTMPEventTypes;
	import com.paperworld.flash.player.Player;
	import com.paperworld.pv3d.scenes.SynchronisedScene;
	import com.paperworld.pv3d.views.ChequerBoardView;
	
	import org.papervision3d.view.AbstractView;
	
	import flash.events.Event;	

	/**
	 * @author Trevor
	 */
	public class HelloPaperWorldClientPV3D extends ChequerBoardView 
	{
		private var logger : Logger;

		private var player : Player;

		public function HelloPaperWorldClientPV3D()
		{			
			super();
			
			var linkageEnforcer : LinkageEnforcer = new LinkageEnforcer( );
			
			var context : CoreContext = CoreContext.getInstance( );
			
			context.addContexts( [ 'logging-context.xml', 'multiplayer-context.xml', 'connection-context.xml' ] );
			context.addEventListener( Event.COMPLETE, onContextLoaded );
			context.load( );			
		}

		private function onContextLoaded(event : Event) : void 
		{
			logger = LoggerContext.getLogger( HelloPaperWorldClientPV3D );
			
			initialise( );
		}

		override public function initialise() : void
		{			
			logger.info( "initialising" );
			
			super.initialise( );
			
			//floor.y = -50;
			
			var connector : RTMPConnector = new RTMPConnector( );
			connector.addEventListener( RTMPEventTypes.CONNECTED_TO_SERVER, onConnectedToServer );
			
			var input : IUserInput = new BasicKeyboardInput( );
			input.target = stage;
			
			connector.input = input;
			
			syncScene = new SynchronisedScene( scene );
			syncScene.connector = connector;
			syncScene.connect( "test" );
			
			player = new Player( );			
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