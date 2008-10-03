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
package com.paperworld.input 
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import com.paperworld.core.patterns.Command;
	import com.paperworld.input.AbstractUserInput;	

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class KeyboardInput extends AbstractUserInput 
	{
		//private var logger : XrayLog = new XrayLog( );
		
		protected var _keyUpCommands:Array;
		
		protected var _keyDownCommands:Array;

		override public function set target(value : Stage) : void
		{
			super.target = value;
				
			_target.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			_target.addEventListener( KeyboardEvent.KEY_UP, onKeyUp );
		}

		public function KeyboardInput()
		{
			super( );
		}

		override public function initialise() : void
		{
			super.initialise();
			
			_keyUpCommands = new Array();
			_keyDownCommands = new Array();
			
			_commands[0] = _keyUpCommands;
			_commands[1] = _keyDownCommands;	
		}

		public function onClick(event : MouseEvent) : void
		{
		}

		/**
		 * Handles a key being pressed. Updates the <code>InputData</code> object.
		 */
		public function onKeyDown( event : KeyboardEvent ) : void 
		{	
			var command : Command = Command( _keyDownCommands[event.keyCode] );
			
			if (command) command.execute( );
		}

		/**
		 * Handles a key being released. Updates the <code>InputData</code> object.
		 */
		public function onKeyUp( event : KeyboardEvent ) : void 
		{
			var command : Command = Command( _keyUpCommands[event.keyCode] );
			
			if (command) command.execute( );
		}
	}
}
