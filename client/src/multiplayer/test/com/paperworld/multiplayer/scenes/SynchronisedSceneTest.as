package com.paperworld.multiplayer.scenes 
{
	import flash.events.Event;
	
	import com.paperworld.multiplayer.events.SynchronisedSceneEvent;
	import com.paperworld.multiplayer.scenes.AbstractSynchronisedScene;
	
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;	

	/**
	 * @author Trevor
	 */
	public class SynchronisedSceneTest extends TestCase 
	{
		public function SynchronisedSceneTest(methodName : String = null)
		{
			super( methodName );
		}

		public function testLoadContext() : void
		{
			var scene : AbstractSynchronisedScene = new AbstractSynchronisedScene( );
			scene.addEventListener( SynchronisedSceneEvent.CONTEXT_LOADED, addAsync( onLoadContext, 2000 ) );
			scene.loadContext( "testContext.xml" );
		}

		private function onLoadContext(event : Event) : void
		{
			var scene : AbstractSynchronisedScene = AbstractSynchronisedScene( event.target );
			
			assertNotNull( "scene is not null", scene );
			//assertNotNull( "scene.connection is not null", scene.connection );
			//assertFalse( "scene.connection.connected == false", scene.connection.connected );
		}

		public function testConnect() : void
		{
			var scene : AbstractSynchronisedScene = new AbstractSynchronisedScene( );
			scene.addEventListener( SynchronisedSceneEvent.CONNECTED_TO_SERVER, addAsync( onConnectedToServer, 5000 ) );
			scene.connect( null, "testContext.xml" );	
		}

		private function onConnectedToServer(event : Event) : void
		{
			var scene : AbstractSynchronisedScene = AbstractSynchronisedScene( event.target );
			
			assertNotNull( "scene is not null", scene );
			//assertNotNull( "scene.connection is not null", scene.connection );
			//assertTrue( "scene.connection.connected == true", scene.connection.connected );	
		}

		/**
		 * Setup the flexunit suite
		 **/
		public static function suite() : TestSuite 
		{
			var suite : TestSuite = new TestSuite( );
			
			//suite.addTest( new SynchronisedSceneTest( "testLoadContext" ) );
			suite.addTest( new SynchronisedSceneTest( "testConnect" ) );
			
			return suite;
		}
	}
}
