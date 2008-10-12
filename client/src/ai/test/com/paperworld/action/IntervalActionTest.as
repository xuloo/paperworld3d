package com.paperworld.action 
{
	import com.paperworld.action.IntervalAction;	
	
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;	

	/**
	 * @author Trevor
	 */
	public class IntervalActionTest extends TestCase 
	{
		public function IntervalActionTest(methodName : String = null)
		{
			super( methodName );
		}

		public function testCanSync() : void
		{
			var sync : IntervalAction = new IntervalAction( );
			sync.time = 5;
			sync.interval = 10;
			
			assertTrue( "Expecting sync.canSync() == true", sync.canAct );
			assertFalse( "Expecting sync.canSync() == false", sync.canAct );			
		}

		/**
		 * Setup the flexunit suite
		 **/
		public static function suite() : TestSuite 
		{
			var suite : TestSuite = new TestSuite( );
			
			suite.addTest( new IntervalActionTest( "testCanSync" ) );
			
			return suite;
		}
	}
}
