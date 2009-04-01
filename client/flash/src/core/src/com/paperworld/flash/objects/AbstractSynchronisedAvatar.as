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
	import com.paperworld.api.IBehaviour;
	import com.paperworld.api.ISynchronisedAvatar;
	import com.paperworld.api.ISynchronisedObject;
	import com.paperworld.flash.ai.steering.SteeringOutput;
	import com.paperworld.flash.behaviours.SimpleAvatarBehaviour25D;
	import com.paperworld.flash.data.State;
	import com.paperworld.flash.input.IUserInput;
	import com.paperworld.flash.input.Input;
	import com.paperworld.flash.util.clock.Clock;
	import com.paperworld.flash.util.clock.IClockListener;
	import com.paperworld.flash.util.clock.events.ClockEvent;
	import com.paperworld.flash.util.logging.Logger;
	import com.paperworld.flash.util.logging.LoggerContext;	

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class AbstractSynchronisedAvatar implements ISynchronisedAvatar, IClockListener
	{
		private var logger : Logger = LoggerContext.getLogger( AbstractSynchronisedAvatar );

		public function set userInput(value : IUserInput) : void
		{
		}

		/**
		 * AbstractSynchronisedScene stores SyncObject instances in a single linked list
		 * as an optimisation for iterating over the synchronisable objects in a scene.
		 */
		protected var _next : ISynchronisedAvatar;

		public function getNext() : ISynchronisedAvatar
		{
			return _next;
		}

		public function setNext(value : ISynchronisedAvatar) : void
		{
			_next = value;
		}

		public var synchronisedObject : ISynchronisedObject;

		public function getSynchronisedObject() : ISynchronisedObject
		{
			return synchronisedObject;
		}	

		public function setSynchronisedObject(value : ISynchronisedObject) : void
		{
			synchronisedObject = value;
		}

		/**
		 * The default tightness for adaptive smoothing.
		 */
		public var defaultTightness : Number = 0.1;

		/**
		 * The 'loosest' tightness allowed in the adaptive smoothing algorithm.
		 */
		public var smoothTightness : Number = 0.01;

		/**
		 * The current tightness value for adaptive smoothing.
		 */
		protected var _tightness : Number;

		public function getTightness() : Number
		{
			return _tightness;
		}

		public function setTightness(tightness : Number) : void
		{
			_tightness = tightness;
		}

		/**
		 * The AvatarBehaviour instance used to interpret user input for this SyncObject.
		 */
		protected var _behaviours : IBehaviour;

		public function setBehaviour(behaviour : IBehaviour) : void
		{
			behaviour.next = _behaviours;
			_behaviours = behaviour;
		}

		/**
		 * The current user input state for this object.
		 */
		protected var _input : Input;

		public function getInput() : Input
		{
			return _input;
		}

		public function setInput(input : Input) : void
		{
			_input = input;
		}

		/**
		 * The State of this object in the previous frame.
		 */
		protected var _previous : State;

		/**
		 * The State of this object in the current frame.
		 */
		protected var _current : State;

		/**
		 * Returns the current State of this object.
		 */
		public function getState() : State
		{
			return _current;	
		}

		/**
		 * @private
		 */
		public function setState(value : State) : void
		{
			_previous = _current;
			_current = value;
		}

		protected var output : SteeringOutput;	

		/**
		 * The current time stream for this object.
		 */
		public var _time : Number = 0;

		public function getTime() : int
		{
			return _time;
		}

		public function setTime(time : int) : void
		{
			_time = time;
		}

		/**
		 * Flagged true if this object is currently replaying from it's Move history buffer.
		 */
		public var _replaying : Boolean;

		public function getReplaying() : Boolean
		{
			return _replaying;
		}

		public function setReplaying(replaying : Boolean) : void
		{
			_replaying = replaying;
		}

		public function AbstractSynchronisedAvatar() 
		{
		}

		public function update() : void
		{			
			_tightness += (defaultTightness - _tightness) * 0.01;
					
			synchronisedObject.synchronise( _time, _input, _current );	
		}

		public function synchronise(time : int, input : Input, state : State) : void
		{
		}

		/**
		 * Immediately sets the State of this object to the State passed. Handles
		 * cases where the update from the server is showing us that we're wildly 
		 * out of sync, there's no point in smoothing - so we just 'snap'.
		 */
		public function snap(state : State) : void
		{
			_previous = _current.clone( );
			_current = state.clone( );
		}

		/**
		 * Loosen the tightness of adaptive smoothing (called when we've just
		 * synchronised with a server update, we can relax for a moment!).
		 */
		public function smooth() : void
		{
			_tightness = smoothTightness;
		}

		/**
		 * Initialise implementation. Sets up any required objects/values.
		 */
		public function initialise() : void
		{
			_tightness = defaultTightness;	
			_time = 0;
			_replaying = false;
			
			_input = new Input( );
			_current = new State( );
			_previous = new State( );
			
			_behaviours = new SimpleAvatarBehaviour25D( );
			
			output = new SteeringOutput( );
			
			Clock.getInstance( ).addListener( this );
		}

		/**
		 * Destroy implementation. Clean up and remove references so GC can work correctly.
		 */
		public function destroy() : void 
		{
			_time = NaN;
			_tightness = NaN;
			defaultTightness = NaN;
			smoothTightness = NaN;
			
			_input.destroy( );
			_current.destroy( );	
			_previous.destroy( );
		}

		/**
		 * Determine if this SyncObject is in the same state as another SyncObject instance.
		 */
		public function equals(other : AbstractSynchronisedAvatar) : Boolean
		{				
			return  _tightness == other.getTightness( ) && _time == other.getTime( ) && _input.equals( other.getInput( ) ) && _current.equals( other.getState( ) );	
		}

		public function onTick(event : ClockEvent) : void
		{
			if (event.type == ClockEvent.TIMESTEP)
				update( );
		}

		public function toString() : String
		{
			return '[Avatar: ' + synchronisedObject + ']';
		}

		protected var _ref : String;

		public function getRef() : String
		{
			return _ref;
		}

		public function setRef(ref : String) : void
		{
			_ref = ref;
		}
	}
}