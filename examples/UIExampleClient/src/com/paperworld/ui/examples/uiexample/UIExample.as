package com.paperworld.ui.examples.uiexample 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;

	import com.paperworld.ui.controls.buttons.BasicButton;	

	/**
	 * @author Trevor
	 */
	public class UIExample extends Sprite 
	{

		[Embed(source="../../../../../../assets/Button.png")]
		private var ButtonClass : Class;

		public function UIExample()
		{
			initButton( );
		}

		public function initButton() : void
		{
			var button : BasicButton = new BasicButton( this, 'button', 0, 0, ButtonClass );
		}
	}
}
