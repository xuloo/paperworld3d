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
package com.paperworld.flash.connectors 
{
	import com.actionengine.flash.core.context.CoreContext;	
	import com.actionengine.flash.core.EventDispatchingBaseClass;	

	import flash.events.Event;
	import flash.net.Responder;

	import com.actionengine.flash.core.context.ContextLoader;
	import com.actionengine.flash.input.IUserInput;
	import com.actionengine.flash.input.IUserInputListener;
	import com.actionengine.flash.input.events.UserInputEvent;
	import com.actionengine.flash.util.logging.Logger;
	import com.actionengine.flash.util.logging.LoggerContext;
	import com.paperworld.flash.connectors.IConnector;
	import com.paperworld.flash.connectors.IConnectorListener;
	import com.paperworld.flash.player.Player;

	import jedai.net.rpc.Red5Connection;	

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class AbstractConnector extends EventDispatchingBaseClass implements IConnector, IUserInputListener
	{
		private var logger : Logger = LoggerContext.getLogger( AbstractConnector );

		protected var _context : CoreContext;

		protected var _userInput : IUserInput;

		protected var _responder : Responder;

		public function get id() : String
		{
			return "";
		}

		/**
		 * Flagged true if the connect() method has been called and either the context hasn't been loaded yet
		 * or if the connection to the server hasn't been established yet. While the load is happening and/or
		 * the connection is being established this flag is checked to see if the scene needs to do anything else.
		 */
		protected var _connecting : Boolean = false;	

		public var sceneName : String;

		protected var _connection : Red5Connection;		

		public function get connection() : Red5Connection
		{
			return _connection;	
		}

		/**
		 * Returns true if a connection to the server has been established.
		 */
		public function get connected() : Boolean
		{
			if (_connection == null)
				return false;
			
			return _connection.connected;
		}

		public function AbstractConnector()
		{
			super( );			
		}

		override public function initialise() : void 
		{
			_context = CoreContext.getInstance( );
		}

		public function connect(scene : String = null, context : String = "connectionContext.xml") : void
		{			
			_connecting = true;
			
			// If a sceneName has been passed as an argument, that's the scene we'll be connecting to.
			if (sceneName) this.sceneName = sceneName;			

			// If there's no rtmp connection established with the server...
			if (!connected)
			{
				// Connect to the server.
				connectToServer( );
			}
		}

		public function connectToServer(event : Event = null) : void
		{
		}

		public function disconnect() : void
		{
		}

		public function onInputUpdate(event : UserInputEvent) : void
		{
		}

		public function get input() : IUserInput
		{
			return _userInput;
		}

		public function set input(value : IUserInput) : void
		{
			_userInput = value;
			
			_userInput.addListener( this );
		}

		public function addPlayer(player : Player) : void
		{
		}

		public function addListener(listener : IConnectorListener) : void
		{
		}

		public function removeListener(listener : IConnectorListener) : void
		{
		}
	}
}