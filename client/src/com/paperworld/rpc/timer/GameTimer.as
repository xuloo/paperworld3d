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
package com.paperworld.rpc.timer
{
	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.rpc.input.IUserInput;
	import com.paperworld.rpc.timer.events.IntegrationEvent;
	import com.paperworld.rpc.timer.events.RenderEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;	

	/**
	 * Dispatched when a physics timestep duration has 
	 * passed and the game object's states need updating
	 * 
	 * @eventType INTEGRATION_EVENT
	 */	
	[Event(name="IntegrationEvent",type="com.paperworld.games.common.timer.IntegrationEvent")]

	/**
	 * Dispatched on each 'tick' of the game clock, 
	 * triggers the repainting of the screen.
	 * 
	 * @eventType RENDER_EVENT
	 */	
	[Event(name="RenderEvent",type="com.paperworld.games.common.timer.RenderEvent")]

	/**
	 * The <code>GameTimer</code> wraps a timer MovieClip - when the MovieClip's ENTER_FRAME event fires
	 * it checks to see how long has passed since the last update and tries to keep the updating
	 * of the game object's states in sync with the server time, in order to prevent users with fast 
	 * computers being able to outperform those with slower machines.
	 */
	public final class GameTimer extends EventDispatcher
	{
		/**
		 * The duration between each 'physics' update on the game objects.
		 * This value is kept constant across all clients and the server to try and
		 * ensure that all object's behaviour is deterministic.
		 */
		public static var FPS : Number = 25;

		public static var TIMESTEP : Number = 1000 / FPS;

		/**
		 * The number of 'phsyics ticks' since the game began.
		 * This value is used by the client->server connection synching code to
		 * wind back when a sync update is received from the server to ensure that
		 * the client is seeing their object in the same position that all
		 * other remote clients are seeing it.
		 */
		public var time : int

		/**
		 * The input handler - used to capture user input.
		 */
		public var input : IUserInput;
		
		private var logger:XrayLog = new XrayLog();

		public function GameTimer( target : IEventDispatcher = null )
		{
			super( target );
						
			time = 0;
			accumulator = 0.0;			
			
			initialiseTimer( );
		}

		/**
		 * Returns the Singleton instance of this class.
		 */
		public static function getInstance() : GameTimer 
		{
			if ( $instance == null )
   				$instance = new GameTimer( );
			
			return $instance;
		}

		/**
		 * Starts the simulation running.
		 */
		public function start() : void 
		{
			logger.info("Starting game timer");
			
			absoluteTime = getTimer( );
			$timer.addEventListener( TimerEvent.TIMER, tick );
			$timer.start();
		}

		/**
		 * Pause/Resume the simulation.
		 */
		public function pause() : void 
		{
			$paused = !$paused;
		}

		/**
		 * Stop the simulation.
		 */
		public function stop() : void 
		{
			$timer.removeEventListener( Event.ENTER_FRAME, tick );
		}

		/**
		 * Sets the initial framerate for the simulation
		 * Creates the MovieClip instance that will be used for timing.
		 */
		private function initialiseTimer() : void 
		{			
			$timer = new Timer(0);
		}

		/**
		 * The Singleton instance of this class.
		 */
		private static var $instance : GameTimer;

		/**
		 * MovieClip used for handling updates.
		 */
		private var $timer : Timer;

		/**
		 * Keeps track of whether the simulation is currently paused or not.
		 */
		private var $paused : Boolean = false;

		/**
		 * Holds a reference to the current lifetime of the simulation.
		 */
		private var absoluteTime : Number;

		/**
		 * 'Accumulates' delta-t - when the accumulator's value is larger than TIMESTEP we
		 * get a physics update.
		 */
		private var accumulator : Number;

		/**
		 * Handles the ENTER_FRAME event of the timer MovieClip.
		 * Checks to see if there's more time in the accumulator than the value of TIMESTEP
		 * If there is then it keeps performing physics updates until the accumulator's value
		 * is lower than TIMESTEP
		 * Then triggers the screen to repaint.
		 */
		private function tick( event : TimerEvent ) : void 
		{						
			if ( !$paused )
			{
				// find the change in time since the last tick 
				// (don't rely on the timer to be accurate)
				var newTime : Number = getTimer( );
				var deltaTime : Number = newTime - absoluteTime;
		
				absoluteTime = newTime;	
				accumulator += deltaTime;
				
				// update discrete time	
				while ( accumulator >= TIMESTEP )
				{		        	
					// advance the simulation
					dispatchEvent( new IntegrationEvent( time, input ) );
		        	
					// advance discrete time		
					accumulator -= TIMESTEP;
					time++;
				}
		        
				// TODO: use this value to create an adaptive framerate for the simulation rendering
				// ie. feedback this value to the MovieClip being used as the timer.
				dispatchEvent( new RenderEvent( input ) );
		         //dispatchEvent( new IntegrationEvent( time, input ) );
			}
		}
	}
}