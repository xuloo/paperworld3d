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
	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.core.BaseClass;
	import com.paperworld.input.Input;
	import com.paperworld.input.UserInput;
	import com.paperworld.input.events.UserInputEvent;
	import com.paperworld.interpolators.Interpolator;
	import com.paperworld.multiplayer.behaviours.AvatarBehaviour;
	import com.paperworld.multiplayer.connectors.LagListener;
	import com.paperworld.multiplayer.data.State;
	import com.paperworld.multiplayer.events.ServerSyncEvent;
	import com.paperworld.multiplayer.scenes.AbstractSynchronisedScene;
	import com.paperworld.util.Synchronizable;
	import com.paperworld.util.clock.Clock;
	import com.paperworld.util.clock.events.ClockEvent;
	import com.paperworld.multiplayer.connectors.events.LagEvent;		

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class Avatar extends BaseClass implements LagListener
	{
		public function set userInput(value : UserInput) : void
		{
			value.addEventListener( UserInputEvent.INPUT_CHANGED, updateClientInput );
		}

		public function set input(value : Input) : void
		{
			client.input = value;
			proxy.input = value;
		}

		public function set state(value : State) : void
		{
			client.state = value.clone( );
			proxy.state = value.clone( );	
		}

		public function set time(value : int) : void
		{
			client.time = value;
		}

		public var next : Avatar;

		/**
		 * The scene this Avatar is currently in.
		 */
		public var scene : AbstractSynchronisedScene;

		/**
		 * The Synchronizable object that this Avatar represents in the 3D scene.
		 */
		public function set syncObject(value : Synchronizable) : void
		{
			logger.info( "setting syncObject " + value );
			client.syncObject = value;
		}

		public function get syncObject() : Synchronizable
		{
			return client.syncObject;
		}

		/**
		 * Interpolator used to smooth between states.
		 */
		public var interpolator : Interpolator;

		/**
		 * Behaviour used to interpret user input.
		 */
		public function set behaviour(value : AvatarBehaviour) : void
		{
			client.behaviour = value;
			proxy.behaviour = value;
		}

		/**
		 * The Proxy object - this is a direct representation of the object on the server.
		 */
		public var proxy : Proxy;

		/**
		 * The Local object - this object responds directly to user input - it represents the client-side prediction.
		 */
		protected var _client : Client;

		public function get client() : Client
		{
			return _client;	
		}

		public function set client(value : Client) : void
		{
			_client = value;
			logger.info( "setting client " + value + " " + _client );
		}

		private var logger : XrayLog = new XrayLog( );

		public function Avatar()
		{
			super( );
		}

		override public function initialise() : void
		{
			//client = new Client( );
			proxy = new Proxy( );
			
			Clock.getInstance( ).addEventListener( ClockEvent.TIMESTEP, update );
		}

		/**
		 * Handles a sync event from the RemoteSharedObject.
		 * Checks if the avatar is able to sync yet - if so, perform the sync action.
		 * If not then store the action so it can be performed when sync is available.
		 */
		public function synchronise(event : ServerSyncEvent) : void
		{
			var time : int = event.data.t;
			var state : State = event.data.state;
			var input : Input = event.data.input;
			
			client.synchronise( time, state, input );
			proxy.synchronise( time, state, input );
		}

		public function update(event : ClockEvent) : void
		{			
			client.update( );
			proxy.update( );	
		}

		public function updateClientInput(event : UserInputEvent) : void
		{
			client.input = event.input;
		}

		/**
		 * Destroy implementation.
		 * Remove listener from RemoteSharedObject.
		 */
		override public function destroy() : void
		{			
			client.destroy( );
			proxy.destroy( );
		}

		public function onLagUpdate(event : LagEvent) : void
		{
			client.onLagUpdate( event );
		}
	}
}
