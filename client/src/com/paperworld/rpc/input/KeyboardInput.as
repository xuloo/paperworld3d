/*
 * --------------------------------------------------------------------------------------
 * PaperWorld3D - building better worlds
 * --------------------------------------------------------------------------------------
 * Realtime 3D Multi-User Application Framework for the Flash Platform.
 * --------------------------------------------------------------------------------------
 * Copyright (C) 2008 Trevor Burton [worldofpaper@googlemail.com]
 * --------------------------------------------------------------------------------------
 * 
 * This library is free software; you can redistribute it and/or modify it under the 
 * terms of the GNU Lesser General Public License as published by the Free Software 
 * Foundation; either version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT ANY 
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A 
 * PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License along with 
 * this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, 
 * Suite 330, Boston, MA 02111-1307 USA 
 * 
 * --------------------------------------------------------------------------------------
 */
package com.paperworld.rpc.input
{
	import com.paperworld.PaperWorld;
	import com.paperworld.rpc.util.KeyDefinitions;
	
	import flash.display.DisplayObject;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;	

	/**
	 * <p>Provides a means of handling input from the user via a Keyboard and Mouse setup.</p>
	 */
	public class KeyboardInput extends AbstractUserInput
	{
		/**
		 * Sensitivity of the mouse values. The large this value is the less angular movement
		 * you'll get with your player's avatar.
		 */
		public var sensitivity : Number = 300;

		public var threshold : Number = 0;

		/**
		 * A reference to the stage is held in the instance in order to calculate the proportion of the 
		 * screen space to calculate the mouseX/mouseY values.
		 */
		public var stage : DisplayObject;		
		
		//private var logger:XrayLog = new XrayLog();

		/**
		 * Constructor.
		 */
		public function KeyboardInput( time : int = 0 )
		{
			super( time );
			
			stage = PaperWorld.getInstance( ).stage;
			logger.info("has listener; " + stage);
			stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			stage.addEventListener( KeyboardEvent.KEY_UP, onKeyUp );	        
			stage.addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
			stage.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener( MouseEvent.MOUSE_UP, onMouseUp);
			
		}

		/**
		 * Handles a key being pressed. Updates the <code>InputData</code> object.
		 */
		private function onKeyDown( event : KeyboardEvent ) : void 
		{
			logger.info("key down: " + event.keyCode);
			
			switch ( event.keyCode )
			{
				case KeyDefinitions.LEFT_ARROW:
					current.left = true;
					break;
	
				case KeyDefinitions.RIGHT_ARROW:
					current.right = true;
					break;
	
				case KeyDefinitions.UP_ARROW:
					current.up = true;
					break;
	
				case KeyDefinitions.DOWN_ARROW:
					current.down = true;
					break;
	
				case KeyDefinitions.SPACEBAR:
					current.space = true;
					break;
	
				case KeyDefinitions.ENTER:
					current.enter = true;
					break;
	
				case KeyDefinitions.CONTROL:
					current.control = true;
					break;
	
				case KeyDefinitions.ESC:
					current.escape = true;
					break;
	
				case KeyDefinitions.PAGE_UP:
					current.pageUp = true;
					break;
	
				case KeyDefinitions.PAGE_DOWN:
					current.pageDown = true;
					break;
	                
				case KeyDefinitions.W:
					current.W = true;
					break;
	            	
				case KeyDefinitions.S:
					current.S = true;
					break;
	           
				case KeyDefinitions.D:
					current.D = true;
					break;
	            	
				case KeyDefinitions.A:
					current.A = true;
					break;
	            
				case KeyDefinitions.K:
					current.K = true;
					break;
	            	
				case KeyDefinitions.M:
					current.M = true;
					break;
	            	
				case KeyDefinitions.ONE:
					current.ONE = true;
					break;
	            	
				case KeyDefinitions.TWO:
					current.TWO = true;
					break;
	
				case KeyDefinitions.F1:
					current.f1 = true;
					break;
	
				case KeyDefinitions.F2:
					current.f2 = true;
					break;
	
				case KeyDefinitions.F3:
					current.f3 = true;
					break;
	
				case KeyDefinitions.F4:
					current.f4 = true;
					break;
	
				case KeyDefinitions.F5:
					current.f5 = true;
					break;
	
				case KeyDefinitions.F6:
					current.f6 = true;
					break;
	
				case KeyDefinitions.F7:
					current.f7 = true;
					break;
	
				case KeyDefinitions.F8:
					current.f8 = true;
					break;
	
				case KeyDefinitions.F9:
					current.f9 = true;
					break;
			}
	        
			$hasChanged = true;
		}

		/**
		 * Handles a key being released. Updates the <code>InputData</code> object.
		 */
		private function onKeyUp( event : KeyboardEvent ) : void 
		{
			logger.info("key up: " + event.keyCode);
						
			switch ( event.keyCode )
			{
				case KeyDefinitions.LEFT_ARROW:
					current.left = false;
					break;
	
				case KeyDefinitions.RIGHT_ARROW:
					current.right = false;
					break;
	
				case KeyDefinitions.UP_ARROW:
					current.up = false;
					break;
	
				case KeyDefinitions.DOWN_ARROW:
					current.down = false;
					break;
	
				case KeyDefinitions.SPACEBAR:
					current.space = false;
					break;
	
				case KeyDefinitions.ENTER:
					current.enter = false;
					break;
	
				case KeyDefinitions.CONTROL:
					current.control = false;
					break;
	
				case KeyDefinitions.ESC:
					current.escape = false;
					break;
	
				case KeyDefinitions.PAGE_UP:
					current.pageUp = false;
					break;
	
				case KeyDefinitions.PAGE_DOWN:
					current.pageDown = false;
					break;
	                
				case KeyDefinitions.W:
					current.W = false;
					break;
	            	
				case KeyDefinitions.S:
					current.S = false;
					break;
	           
				case KeyDefinitions.D:
					current.D = false;
					break;
	            	
				case KeyDefinitions.A:
					current.A = false;
					break;
	            	
				case KeyDefinitions.K:
					current.K = true;
					break;
	            	
				case KeyDefinitions.M:
					current.M = true;
					break;
	            	
				case KeyDefinitions.ONE:
					current.ONE = true;
					break;
	            	
				case KeyDefinitions.TWO:
					current.TWO = true;
					break;
	
				case KeyDefinitions.F1:
					current.f1 = false;
					break;
	
				case KeyDefinitions.F2:
					current.f2 = false;
					break;
	
				case KeyDefinitions.F3:
					current.f3 = false;
					break;
	
				case KeyDefinitions.F4:
					current.f4 = false;
					break;
	
				case KeyDefinitions.F5:
					current.f5 = false;
					break;
	
				case KeyDefinitions.F6:
					current.f6 = false;
					break;
	
				case KeyDefinitions.F7:
					current.f7 = false;
					break;
	
				case KeyDefinitions.F8:
					current.f8 = false;
					break;
	
				case KeyDefinitions.F9:
					current.f9 = false;
					break;
			}
	        
			$hasChanged = true;
		}
		
		private function onMouseDown(event:MouseEvent):void 
		{
			logger.info("Mouse Down");
			
			current.W = true;
			
			$hasChanged = true;
		}
		
		private function onMouseUp(event:MouseEvent):void 
		{
			logger.info("Mouse Up");
			
			current.W = false;
			
			$hasChanged = true;
		}

		/**
		 * Handles a mouse move. Updates the <code>InputData</code> object.
		 */
		private function onMouseMove( event : MouseEvent ) : void
		{			
			var x : Number = ( event.stageX - ( stage.width / 2 ) ) / sensitivity;
			var y : Number = ( event.stageY - ( stage.height / 2 ) ) / sensitivity;
			
			var squareDistance : Number = x * x + y * y;
			
			if (squareDistance > threshold)
			{
				current.mouseX = x;
				current.mouseY = y;	
				$hasChanged = true;
			}
		}
	}
}