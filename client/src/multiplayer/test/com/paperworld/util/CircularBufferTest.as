package com.paperworld.util
{
	import com.paperworld.util.CircularBuffer;
	import com.paperworld.util.Move;

	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;		
	/**
	 * @author Trevor
	 */
	public class CircularBufferTest extends TestCase 
	{
		public function CircularBufferTest(methodName : String = null)
		{
			super( methodName );
		}

		public function testAdd() : void
		{
			var buffer : CircularBuffer = new CircularBuffer( );
			var move : Move = new Move( );
			
			buffer.add( move );
			
			assertTrue( "Expecting buffer.moves.length == 1", buffer.moves.length, 1 );
			assertTrue( "Expecting buffer.moves[0] == move", buffer.moves[0], move );
		}
		
		public function testGetSize():void
		{
				
		}

		/**
		 * Setup the flexunit suite
		 **/
		public static function suite() : TestSuite 
		{
			var suite : TestSuite = new TestSuite( );
			
			suite.addTest( new CircularBufferTest( "testAdd" ) );
			
			return suite;
		}
	}
}
