/* --------------------------------------------------------------------------------------
 * PaperWorld3D - building better worlds
 * --------------------------------------------------------------------------------------
 * Real-Time Multi-User Application Framework for the Flash Platform.
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
 * -------------------------------------------------------------------------------------- */
package com.paperworld.flash.core.input 
{
	import com.paperworld.flash.util.keys.KeyDefinitions;
	import com.paperworld.flash.util.keys.KeyDownCommand;
	import com.paperworld.flash.util.keys.KeyUpCommand;	

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class BasicKeyboardInput extends KeyboardInput 
	{
		public function BasicKeyboardInput()
		{
			super( );
		}
		
		override public function initialise():void
		{
			super.initialise();
			
			// Handle Forward Key Press - mapped to 'w' key.
			var forwardKeyUpCommand : KeyUpCommand = new KeyUpCommand(this );
			forwardKeyUpCommand.property = 'forward';
			
			var forwardKeyDownCommand : KeyDownCommand = new KeyDownCommand(this );
			forwardKeyDownCommand.property = 'forward';
			
			_keyUpCommands[KeyDefinitions.W] = forwardKeyUpCommand;
			_keyDownCommands[KeyDefinitions.W] = forwardKeyDownCommand;
			
			// Handle Back Key Press - mapped to 's' key.
			var backKeyUpCommand : KeyUpCommand = new KeyUpCommand(this );
			backKeyUpCommand.property = 'back';
			
			var backKeyDownCommand : KeyDownCommand = new KeyDownCommand(this );
			backKeyDownCommand.property = 'back';
			
			_keyUpCommands[KeyDefinitions.S] = backKeyUpCommand;
			_keyDownCommands[KeyDefinitions.S] = backKeyDownCommand;
			
			// Handle Right Key Press - mapped to 'd' key.
			var rightKeyUpCommand : KeyUpCommand = new KeyUpCommand(this );
			rightKeyUpCommand.property = 'moveRight';
			
			var rightKeyDownCommand : KeyDownCommand = new KeyDownCommand(this );
			rightKeyDownCommand.property = 'moveRight';
			
			_keyUpCommands[KeyDefinitions.D] = rightKeyUpCommand;
			_keyDownCommands[KeyDefinitions.D] = rightKeyDownCommand;
			
			// Handle Left Key Press - mapped to 'a' key.
			var leftKeyUpCommand : KeyUpCommand = new KeyUpCommand(this );
			leftKeyUpCommand.property = 'moveLeft';
			
			var leftKeyDownCommand : KeyDownCommand = new KeyDownCommand(this );
			leftKeyDownCommand.property = 'moveLeft';
			
			_keyUpCommands[KeyDefinitions.A] = leftKeyUpCommand;
			_keyDownCommands[KeyDefinitions.A] = leftKeyDownCommand;
			
			// Handle Right Arrow Key Press - mapped to '->' key.
			var turnRightKeyUpCommand : KeyUpCommand = new KeyUpCommand(this );
			turnRightKeyUpCommand.property = 'turnRight';
			
			var turnRightKeyDownCommand : KeyDownCommand = new KeyDownCommand(this );
			turnRightKeyDownCommand.property = 'turnRight';
			
			_keyUpCommands[KeyDefinitions.RIGHT_ARROW] = turnRightKeyUpCommand;
			_keyDownCommands[KeyDefinitions.RIGHT_ARROW] = turnRightKeyDownCommand;
			
			// Handle Left Arrow Key Press - mapped to '<-' key.
			var turnLeftKeyUpCommand : KeyUpCommand = new KeyUpCommand(this );
			turnLeftKeyUpCommand.property = 'turnLeft';
			
			var turnLeftKeyDownCommand : KeyDownCommand = new KeyDownCommand(this );
			turnLeftKeyDownCommand.property = 'turnLeft';
			
			_keyUpCommands[KeyDefinitions.LEFT_ARROW] = turnLeftKeyUpCommand;
			_keyDownCommands[KeyDefinitions.LEFT_ARROW] = turnLeftKeyDownCommand;
			
			var fireDownCommand : KeyDownCommand = new KeyDownCommand( this );
			fireDownCommand.property = 'fire';
			
			var fireUpCommand : KeyUpCommand = new KeyUpCommand( this );
			fireUpCommand.property = 'fire';
			
			_keyUpCommands[KeyDefinitions.SPACEBAR] = fireUpCommand;			_keyDownCommands[KeyDefinitions.SPACEBAR] = fireDownCommand;
		}
	}
}
