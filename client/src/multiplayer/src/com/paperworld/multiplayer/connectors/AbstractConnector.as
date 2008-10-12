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
package com.paperworld.multiplayer.connectors 
{
	import flash.events.Event;
	import flash.net.Responder;
	
	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.core.context.ContextLoader;
	import com.paperworld.input.UserInput;
	import com.paperworld.input.UserInputListener;
	import com.paperworld.input.events.UserInputEvent;
	import com.paperworld.multiplayer.connectors.Connector;
	import com.paperworld.multiplayer.events.ServerSyncEvent;
	
	import jedai.net.rpc.Red5Connection;	

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class AbstractConnector extends ContextLoader implements Connector, UserInputListener
	{
		private var logger : XrayLog = new XrayLog( );	

		protected var _userInput : UserInput;

		protected var _responder : Responder;
		
		public function get id():String
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
			return _connection.connected;
		}

		public function AbstractConnector()
		{
			super( );
		}

		public function connect(scene : String = null, context : String = "connectionContext.xml") : void
		{			
			_connecting = true;
			
			// If a sceneName has been passed as an argument, that's the scene we'll be connecting to.
			if (sceneName) this.sceneName = sceneName;			

			// If the context file isn't loaded yet...
			if (!_contextLoaded)
			{
				// load it!
				loadContext( context );
			}
			else
			{
				// If there's no rtmp connection established with the server...
				if (!connected)
				{
					// Connect to the server.
					connectToServer( );
				}
			}
		}

		/**
		 * Called when the context file has been loaded.
		 * Flags the context as having been loaded.
		 * If we're in the process of connecting (ie. the connect() method has been called) then continue.
		 */
		override protected function onContextLoaded(event : Event) : void
		{			
			super.onContextLoaded(event);
			
			if (_connecting) connect( );
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
		
		public function get input() : UserInput
		{
			return _userInput;
		}

		public function set input(value : UserInput) : void
		{
			_userInput = value;
			
			_userInput.addListener( this );
		}
		
		public function addListener(listener : ConnectorListener) : void
		{
			addEventListener( ServerSyncEvent.REMOTE_AVATAR_SYNC, listener.onRemoteAvatarSync );			addEventListener( ServerSyncEvent.LOCAL_AVATAR_SYNC, listener.onLocalAvatarSync );
			addEventListener( ServerSyncEvent.AVATAR_DELETE, listener.onAvatarDelete );
		}
		
		public function removeListener(listener : ConnectorListener) : void
		{
			removeEventListener( ServerSyncEvent.REMOTE_AVATAR_SYNC, listener.onRemoteAvatarSync );			removeEventListener( ServerSyncEvent.LOCAL_AVATAR_SYNC, listener.onLocalAvatarSync );
			removeEventListener( ServerSyncEvent.AVATAR_DELETE, listener.onAvatarDelete );
		}
	}
}
