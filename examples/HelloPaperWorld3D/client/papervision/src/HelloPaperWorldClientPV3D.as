package  
{
	import com.actionengine.flash.core.context.CoreContext;
	import com.actionengine.flash.input.BasicKeyboardInput;
	import com.actionengine.flash.input.IUserInput;
	import com.actionengine.flash.util.clock.Clock;
	import com.actionengine.flash.util.clock.events.ClockEvent;
	import com.actionengine.flash.util.logging.Logger;
	import com.actionengine.flash.util.logging.LoggerContext;
	import com.paperworld.flash.factory.RemoteAndLocalAvatarFactory;
	import com.paperworld.flash.player.Player;
	import com.paperworld.flash.scenes.RTMPEventTypes;
	import com.paperworld.pv3d.scenes.SynchronisedScene;
	import com.paperworld.pv3d.views.ChequerBoardView;
	
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

		override public function initialise(...args) : void
		{			
			logger.info( "initialising" );
			
			super.initialise( );
			
			syncScene = new SynchronisedScene( scene );
			syncScene.userInput = new BasicKeyboardInput( stage );
			syncScene.avatarFactory = new RemoteAndLocalAvatarFactory();
			syncScene.addEventListener( RTMPEventTypes.CONNECTED_TO_SERVER, onConnectedToServer );
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