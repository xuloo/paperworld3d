package  
{
	import flash.display.Sprite;		

	/**
	 * @author Trevor
	 */
	public class Icon extends Sprite 
	{
		public var displayObject : Sprite;

		public function Icon()
		{
			super( );
			
			initialise( );
		}

		private function initialise() : void 
		{
			displayObject = new Sprite( );
			displayObject.graphics.lineStyle( 1, 0x000000 );
			displayObject.graphics.beginFill( 0xff0000 );
			displayObject.graphics.drawCircle( 0, 0, 25 );
			displayObject.graphics.endFill( );
			
			displayObject.graphics.lineTo(0, 25);
			
			addChild( displayObject );
		}
	}
}
