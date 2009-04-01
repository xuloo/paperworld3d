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
package com.paperworld.flash.input 
{
	import com.paperworld.flash.input.events.UserInputEvent;
	import com.paperworld.flash.util.clock.Clock;
	import com.paperworld.flash.util.clock.events.ClockEvent;
	
	import flash.display.Stage;
	import flash.events.EventDispatcher;	

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class AbstractUserInput extends EventDispatcher implements IUserInput 
	{
		/**
		 * The state of the user's input in the current timestep.
		 */
		public var current : Input;

		/**
		 * The state of the user's input in the previous timestep.
		 */
		public var previous : Input;

		protected var _target : Stage;

		public function set target(value : Stage) : void
		{
			_target = value;
		}

		protected var _commands : Array;

		public function AbstractUserInput()
		{
			super( this );
		}

		public function initialise() : void
		{
			current = new Input( );
			previous = new Input( );
			
			_commands = new Array( );
			
			Clock.getInstance( ).addEventListener( ClockEvent.TIMESTEP, update );
		}

		public function get input() : Input
		{
			return current;
		}

		public function update(event : ClockEvent = null) : void
		{			
			if (current.notEquals( previous ))
			{
				dispatchEvent( new UserInputEvent( UserInputEvent.INPUT_CHANGED, event.time, current ) );
				
				previous.copyFrom( current );
			}
		}

		public function get mouseX() : Number
		{
			return 0;
		}

		public function get mouseY() : Number
		{
			return 0;
		}
		
		public function addListener(listener : IUserInputListener) : void
		{
			addEventListener( UserInputEvent.INPUT_CHANGED, listener.onInputUpdate );
		}
		
		public function removeListener(listener : IUserInputListener) : void
		{
			removeEventListener( UserInputEvent.INPUT_CHANGED, listener.onInputUpdate );
		}
	}
}
