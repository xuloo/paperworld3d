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
package com.paperworld.multiplayer.objects 
{
	import com.actionengine.flash.input.UserInput;
	import com.actionengine.flash.input.events.UserInputEvent;
	import com.actionengine.flash.util.clock.events.ClockEvent;
	import com.actionengine.flash.util.logging.Logger;
	import com.actionengine.flash.util.logging.LoggerContext;
	import com.paperworld.multiplayer.connectors.LagListener;
	import com.paperworld.multiplayer.connectors.events.LagEvent;
	import com.paperworld.multiplayer.data.State;
	import com.paperworld.multiplayer.events.ServerSyncEvent;
	import com.paperworld.util.History;
	import com.paperworld.util.Move;		

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class Client extends SyncObject implements LagListener
	{
		protected var _history : History;

		public function set userInput(value : UserInput) : void
		{
			value.addEventListener( UserInputEvent.INPUT_CHANGED, updateClientInput );
		}

		private var logger : Logger = LoggerContext.getLogger( Client );

		public function Client()
		{
			super( );
		}

		override public function initialise() : void
		{
			super.initialise( );
			
			_history = new History( );
		}

		override public function update(event : ClockEvent = null) : void
		{						
			// add to history
			var move : Move = new Move( );
			move.time = time;
			move.input = input.clone( );
			move.state = state.clone( );

			_history.add( move );
			
			// update scene
			super.update( event );		
		}

		override public function synchronise(event : ServerSyncEvent) : void
		{			
			var original : State = state.clone( );

			_history.correction( this, event.time, event.state, event.input );		

			if (original.compare( state ))
            	smooth( );
		}

		public function onServerTimeUpdate(event : LagEvent) : void
		{			
			if (event.time > time)
			{
				deltaTime = 1.25;
			}
			else if (event.time < time)
			{
				deltaTime = 0.75;
			}
			else
			{
				deltaTime = 1.0;
			}
		}

		public function onServerJitterUpdate(event : LagEvent) : void
		{
		}

		public function updateClientInput(event : UserInputEvent) : void
		{
			input = event.input;
			behaviour.input = event.input;
		}
	}
}
