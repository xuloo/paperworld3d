package com.paperworld.action 
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;	

	/**
	 * @author Trevor
	 */
	public class ActionTest extends TestCase 
	{
		public function ActionTest(methodName : String = null)
		{
			super( methodName );
		}

		public function testGetLast() : void
		{
			var action1 : Action = new Action( );
			var action2 : Action = new Action( );
			
			// With no 'next' action added action1.last should return itself.
			assertTrue( "Expecting action1.last == action1", action1.last == action1 );
			
			action1.next = action2;
			
			// Now it should return action2 as the last in the list.
			assertTrue( "Expecting action1.last == action2", action1.last == action2 );
		}

		public function testDeleteList() : void
		{
			var action1 : TestAction = new TestAction( );
			action1.priority = 2;
			
			var action2 : TestAction = new TestAction( );
			action2.priority = 1;
			
			action1.next = action2;
			
			action1.deleteList( );
			
			// Both actions should have been destroyed by destroying the first.
			assertTrue( "Expecting action2.destroyed == true", action2.destroyed );
			assertTrue( "Expecting action1.destroyed == true", action1.destroyed );
		}

		/**
		 * Setup the flexunit suite
		 **/
		public static function suite() : TestSuite 
		{
			var suite : TestSuite = new TestSuite( );
			
			suite.addTest( new ActionTest( "testGetLast" ) );
			suite.addTest( new ActionTest( "testDeleteList" ) );
			
			return suite;
		}
	}
}
