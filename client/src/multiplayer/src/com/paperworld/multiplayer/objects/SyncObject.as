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
	import com.paperworld.core.BaseClass;
	import com.paperworld.input.Input;
	import com.paperworld.multiplayer.behaviours.AvatarBehaviour;
	import com.paperworld.multiplayer.behaviours.SimpleAvatarBehaviour2D;
	import com.paperworld.multiplayer.data.State;
	import com.paperworld.multiplayer.events.ServerSyncEvent;
	import com.paperworld.util.Synchronizable;
	import com.paperworld.util.clock.Clock;
	import com.paperworld.util.clock.events.ClockEvent;	

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class SyncObject extends BaseClass
	{
		/**
		 * AbstractSynchronisedScene stores SyncObject instances in a single linked list
		 * as an optimisation for iterating over the synchronisable objects in a scene.
		 */
		public var next : SyncObject;

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
		public var tightness : Number;

		/**
		 * The AvatarBehaviour instance used to interpret user input for this SyncObject.
		 */
		public var behaviour : AvatarBehaviour;

		/**
		 * The current user input state for this object.
		 */
		public var input : Input;

		/**
		 * The State of this object in the previous frame.
		 */
		public var previous : State;

		/**
		 * The State of this object in the current frame.
		 */
		public var current : State;

		/**
		 * Returns the current State of this object.
		 */
		public function get state() : State
		{
			return current;	
		}

		/**
		 * @private
		 */
		public function set state(value : State) : void
		{
			previous = current;
			current = value;
		}
		
		/**
		 * The visible object in the scene that this object represents over the wire.
		 */
		public var displayObject : Synchronizable;	

		/**
		 * The current time stream for this object.
		 */
		public var time : Number = 0;

		/**
		 * The amount that this object's time will change by on the next update() call.
		 */
		public var deltaTime : Number = 1;
		
		public var lastTime : int = 0;

		/**
		 * Flagged true if this object is currently replaying from it's Move history buffer.
		 */
		public var replaying : Boolean;

		public function update(event : ClockEvent = null) : void
		{			
			tightness += (defaultTightness - tightness) * 0.01;
			//time++;
			time += deltaTime;
			
			var integerTime:int = int(time) - lastTime;
			
			while (integerTime > 0)
			{
				
				integerTime -= 1;
			}
			
			lastTime = int(time);
			
			behaviour.update( input, state );
			displayObject.synchronise( input, state );	
		}

		public function synchronise(event : ServerSyncEvent) : void
		{
		}

		/**
		 * Immediately sets the State of this object to the State passed. Handles
		 * cases where the update from the server is showing us that we're wildly 
		 * out of sync, there's no point in smoothing - so we just 'snap'.
		 */
		public function snap(state : State) : void
		{
			previous = current.clone( );
			current = state.clone( );
		}

		/**
		 * Loosen the tightness of adaptive smoothing (called when we've just
		 * synchronised with a server update, we can relax for a moment!).
		 */
		public function smooth() : void
		{
			tightness = smoothTightness;
		}

		/**
		 * Initialise implementation. Sets up any required objects/values.
		 */
		override public function initialise() : void
		{
			tightness = defaultTightness;	
			time = 0;
			replaying = false;
			
			input = new Input( );
			current = new State( );
			previous = new State( );
			
			behaviour = new SimpleAvatarBehaviour2D( );
			
			Clock.getInstance( ).addEventListener( ClockEvent.TIMESTEP, update );
		}

		/**
		 * Destroy implementation. Clean up and remove references so GC can work correctly.
		 */
		override public function destroy() : void 
		{
			time = NaN;
			tightness = NaN;
			defaultTightness = NaN;
			smoothTightness = NaN;
			
			input.destroy( );
			state.destroy( );	
		}

		/**
		 * Determine if this SyncObject is in the same state as another SyncObject instance.
		 */
		public function equals(other : SyncObject) : Boolean
		{				
			return  tightness == other.tightness && time == other.time && input.equals( other.input ) && state.equals( other.state );	
		}
	}
}
