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
package com.paperworld.flash.objects 
{
	import com.actionengine.flash.input.IUserInput;
	import com.actionengine.flash.input.IUserInputListener;
	import com.actionengine.flash.input.Input;
	import com.actionengine.flash.input.events.UserInputEvent;
	import com.actionengine.flash.util.logging.Logger;
	import com.actionengine.flash.util.logging.LoggerContext;
	import com.brainfarm.flash.data.State;
	import com.paperworld.flash.objects.AbstractSynchronisedAvatar;
	import com.paperworld.util.History;
	import com.paperworld.util.Move;		

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class LocalAvatar extends AbstractSynchronisedAvatar implements IUserInputListener
	{
		protected var _history : History;

		private var logger : Logger = LoggerContext.getLogger( LocalAvatar );

		override public function set userInput(value : IUserInput) : void
		{
			value.addListener( this );
		}

		public function LocalAvatar()
		{
			super( );
		}

		override public function initialise() : void
		{
			super.initialise( );
			
			_history = new History( );
		}

		override public function update() : void
		{						
			// add to history
			var move : Move = new Move( );
			move.time = _time;
			move.input = _input.clone( );
			move.state = _current.clone( );

			_history.add( move );
			
			behaviour.getSteering( output );
			
			_current.velocity = output.linear;
			_current.position.plusEq( output.linear );
			_current.orientation = output.angular;
			
			// update scene
			super.update( );		
		}

		override public function synchronise(time : int, input : Input, state : State) : void
		{						
			var original : State = state.clone( );

			_history.correction( this, time, state, input );		

			if (original.compare( state ))
            	smooth( );
            	
			// Handle the server time update.
			if (time > _time)
			{
				deltaTime = 1.25;
			}
			else if (time < _time)
			{
				deltaTime = 0.75;
			}
			else
			{
				deltaTime = 1.0;
			}
		}

		public function onInputUpdate(event : UserInputEvent) : void
		{
			_input = event.input;
			behaviour.input = event.input;
		}
	}
}
