package com.paperworld3d.controls.flex.objects
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
		
	public class Bubble extends Sprite
	{
		[Embed(source='images/bubble/tl.png')]
		private var TopLeft:Class;
		
		[Embed(source='images/bubble/tc.png')]
		private var TopCentre:Class;
		
		[Embed(source='images/bubble/tr.png')]
		private var TopRight:Class;
		
		[Embed(source='images/bubble/ml.png')]
		private var MiddleLeft:Class;
		
		[Embed(source='images/bubble/mc.png')]
		private var MiddleCentre:Class;
		
		[Embed(source='images/bubble/mr.png')]
		private var MiddleRight:Class;
		
		[Embed(source='images/bubble/bl.png')]
		private var BottomLeft:Class;
		
		[Embed(source='images/bubble/bc.png')]
		private var BottomCentre:Class;
		
		[Embed(source='images/bubble/br.png')]
		private var BottomRight:Class;
		
		[Embed(source='images/bubble/spike.png')]
		private var Spike:Class;
		
		public static var MAX_WIDTH:Number = 75;
		
		private var textField:TextField;
		
		public function Bubble(message:String)
		{
			super();
						
			
			
			/*var background:Sprite = new Sprite();
			background.graphics.lineStyle(1, 0x000000, 1);
			background.graphics.beginFill(0xffffff, 1);
			background.graphics.drawRoundRect(0, 0, textField.width + (padding * 2), textField.height + (padding * 2), 10, 10);
			background.graphics.endFill();*/
			
			//addChild(background);	
			createBubble(message);		
			y = -height;
		}
		
		private function createBubble(message:String):void 
		{			
			textField = new TextField();
			textField.autoSize = TextFieldAutoSize.LEFT;	
			textField.wordWrap = true;
			textField.multiline = true;					
			textField.htmlText = message;
			
			textField.width = (textField.width > MAX_WIDTH) ? MAX_WIDTH : textField.width;
			
			var topLeft:Bitmap = new TopLeft();
			addChild(topLeft);
			
			textField.x = topLeft.width;
			textField.y = topLeft.height;
			
			var topCentre:Bitmap = new TopCentre();
			topCentre.x = topLeft.width;
			topCentre.width = textField.width;
			addChild(topCentre);
			
			var topRight:Bitmap = new TopRight();
			topRight.x = topLeft.width + topCentre.width;
			addChild(topRight);
			
			var middleLeft:Bitmap = new MiddleLeft();
			middleLeft.y = topLeft.height;
			middleLeft.height = textField.height;
			addChild(middleLeft);
			
			var middleCentre:Bitmap = new MiddleCentre();
			middleCentre.x = middleLeft.width;
			middleCentre.y = topCentre.height;
			middleCentre.width = topCentre.width;
			middleCentre.height = textField.height;
			addChild(middleCentre);			
			
			var middleRight:Bitmap = new MiddleRight();
			middleRight.x = middleLeft.width + middleCentre.width;
			middleRight.y = topRight.height;
			middleRight.height = textField.height;
			addChild(middleRight);
			
			var bottomLeft:Bitmap = new BottomLeft();
			bottomLeft.y = topLeft.height + middleLeft.height;
			addChild(bottomLeft);
			
			var bottomCentre:Bitmap = new BottomCentre();
			bottomCentre.x = bottomLeft.width;
			bottomCentre.y = topCentre.height + middleCentre.height;
			bottomCentre.width = topCentre.width;
			addChild(bottomCentre);
			
			var bottomRight:Bitmap = new BottomRight();
			bottomRight.x = bottomLeft.width + bottomCentre.width;
			bottomRight.y = topRight.height + middleRight.height;
			addChild(bottomRight);
			
			var spike:Bitmap = new Spike();
			spike.x = bottomRight.x - spike.width;
			spike.y = topRight.height + middleRight.height + 13;
			addChild(spike);
			
			addChild(textField);
		}
		
		public function destroy():void 
		{
			removeChild(textField);
		}
		
		public function update(message:String):void 
		{
			textField.htmlText = message;
		}
	}
}