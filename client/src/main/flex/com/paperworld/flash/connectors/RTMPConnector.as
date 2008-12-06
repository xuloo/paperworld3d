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
	import flash.events.Event;
	import flash.events.SyncEvent;
	import flash.net.ObjectEncoding;
	import flash.net.Responder;
	import flash.utils.getTimer;
	
	import com.actionengine.flash.input.events.UserInputEvent;
	import com.actionengine.flash.util.logging.Logger;
	import com.actionengine.flash.util.logging.LoggerContext;
	import com.paperworld.flash.connectors.events.ConnectorEvent;
	import com.paperworld.flash.connectors.events.LagEvent;
	import com.paperworld.flash.data.SyncData;
	import com.paperworld.flash.data.TimedInput;
	import com.paperworld.flash.events.ServerSyncEvent;
	import com.paperworld.flash.player.Player;
	
	import jedai.events.Red5Event;
	import jedai.net.rpc.Red5Connection;
	import jedai.net.rpc.RemoteSharedObject;	

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class RTMPConnector extends AbstractConnector 
	{
		private var logger : Logger = LoggerContext.getLogger( RTMPConnector );

		protected var _remoteSharedObject : RemoteSharedObject;

		public var clientID : Number;

		public var time : int;

		public function RTMPConnector()
		{
			super( );
		}

		override public function initialise() : void
		{
			super.initialise( );
			
			_responder = new Responder( onResult, onStatus );
		}

		/**
		 * Calls the Red5Bootstrapper to establish an rtmp connection with a Red5 server.
		 */
		override public function connectToServer(event : Event = null) : void
		{							
			_connection.addEventListener( Red5Event.CONNECTED, onConnectionEstablished );
			_connection.addEventListener( Red5Event.DISCONNECTED, onConnectionDisconnected );
			_connection.client = this;
			_connection.connect( _connection.rtmpURI, _connection.clientManager.username, _connection.clientManager.password );
		}

		public function setClientID(val : Number) : void
		{
			logger.info( "setting client id == " + val );
			
			clientID = val;	
		}	

		override protected function onContextLoaded(event : Event) : void
		{						
			_connection = _applicationContext.getObject( "connection" ) as Red5Connection;
			_connection.objectEncoding = ObjectEncoding.AMF3;
			
			dispatchEvent( new ConnectorEvent( ConnectorEvent.CONTEXT_LOADED, this ) );
			
			super.onContextLoaded( event );
		}

		/**
		 * Called when a connection has been established.
		 * If we're in the process of connecting (ie. the connect() method has been called) then continue.
		 */
		protected function onConnectionEstablished(event : Red5Event) : void
		{
			logger.info( "connection established" );
			
			dispatchEvent( new ConnectorEvent( ConnectorEvent.CONNECTED_TO_SERVER, this ) );
			
			_remoteSharedObject = new RemoteSharedObject( "avatars", false, false, _connection );
			_remoteSharedObject.addEventListener( SyncEvent.SYNC, synchronise );
			
			_userInput.addEventListener( UserInputEvent.INPUT_CHANGED, onInputUpdate );
		}

		private var player : Player;

		override public function addPlayer(player : Player) : void
		{
			this.player = player;
			
			_connection.call( 'multiplayer.addPlayer', new Responder( addPlayerResult, onResult ), clientID );
		}

		public function addPlayerResult(data : SyncData) : void
		{
			player.avatar.time = data.serverTime;
		}

		protected function onConnectionDisconnected(event : Red5Event) : void
		{
			dispatchEvent( new ConnectorEvent( ConnectorEvent.DISCONNECTED_FROM_SERVER, this ) );	
		}

		/**
		 * Handles a sync event from the RemoteSharedObject.
		 * Iterate over the list of avatars in this scene and apply the LOD heuristics.
		 */
		public function synchronise(event : SyncEvent) : void
		{			
			var changeList : Array = event.changeList;
			var length : int = changeList.length;
			
			// Iterate over event.changelist to check if this Avatar is in the list.
			for (var i : int = 0; i < length ; i++)
			{
				var name : String = changeList[i].name;

				// Decide which action to perform depending on what's happened to the SharedObject.
				switch (changeList[i].code)
				{
					case "change":
						
						var data : SyncData = SyncData( _remoteSharedObject._so.data[name] );
						
						if (name != String( clientID )) 
						{									
							dispatchEvent( new ServerSyncEvent( ServerSyncEvent.REMOTE_AVATAR_SYNC, name, data.serverTime, data.input, data.state ) );						}
						else
						{
							dispatchEvent( new ServerSyncEvent( ServerSyncEvent.LOCAL_AVATAR_SYNC, name, data.serverTime, data.input, data.state ) );
							dispatchEvent( new LagEvent( LagEvent.TIME_UPDATE, data.serverTime ) );
						}
						break;
						
					case "clear":
						break;
						
					case "success":
						logger.info( "changeList[" + i + "].code: " + changeList[i].code );
						break;
						
					case "reject":
						logger.info( "changeList[" + i + "].code: " + changeList[i].code );
						break;
						
					case "delete":
						logger.info( "changeList[" + i + "].code: " + changeList[i].code );
						dispatchEvent( new ServerSyncEvent( ServerSyncEvent.AVATAR_DELETE, name ) );
						break;
							
					default:
						break;	
				}
			}
			
			/*if (canAct)
			{
				// Iterate over heuristics for each avatar to set lod interval.	
				var nextAvatar : Avatar = avatars;
				
				while (nextAvatar)
				{
					if (nextAvatar != pov)
					{
						var nextConstraint : Action = lodConstraints;
					
						while (nextConstraint)
						{
							nextConstraint.act( );
							nextConstraint = nextConstraint.next;
						}
					}
					
					nextAvatar = nextAvatar.next;
				}
			}*/
		}		

		override public function onInputUpdate(event : UserInputEvent) : void
		{			
			time = getTimer( );
			_connection.call( 'multiplayer.receiveInput', _responder, clientID, new TimedInput( event.time, event.input ) );
		}

		public function onResult(data : SyncData) : void
		{			
			dispatchEvent( new ServerSyncEvent( ServerSyncEvent.LOCAL_AVATAR_SYNC, String( clientID ), data.serverTime, data.input, data.state ) );
			
			dispatchEvent( new LagEvent( LagEvent.JITTER_UPDATE, getTimer( ) - time ) );
		}

		public function onStatus(status : Object) : void
		{
			for (var i:String in status)
			{
				logger.info( i + " " + status[i] );
			}
		}

		public function addLagListener(listener : LagListener) : void
		{
			addEventListener( LagEvent.TIME_UPDATE, listener.onServerTimeUpdate );
			addEventListener( LagEvent.JITTER_UPDATE, listener.onServerJitterUpdate );
		}
	}
}
