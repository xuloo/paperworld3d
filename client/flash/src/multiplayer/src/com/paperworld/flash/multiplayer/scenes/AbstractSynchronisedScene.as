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
package com.paperworld.flash.multiplayer.scenes 
{
	import com.paperworld.flash.core.player.Player;
	import com.paperworld.flash.multiplayer.api.IAvatarFactory;
	import com.paperworld.flash.multiplayer.api.ISynchronisedAvatar;
	import com.paperworld.flash.multiplayer.api.ISynchronisedObject;
	import com.paperworld.flash.multiplayer.api.ISynchronisedScene;
	import com.paperworld.flash.multiplayer.data.AvatarData;
	import com.paperworld.flash.multiplayer.data.State;
	import com.paperworld.flash.multiplayer.data.SyncData;
	import com.paperworld.flash.multiplayer.lod.LodConstraint;
	import com.paperworld.flash.util.input.IUserInput;
	import com.paperworld.flash.util.input.events.UserInputEvent;
	import com.paperworld.flash.util.number.Vector3;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.SyncEvent;
	import flash.net.ObjectEncoding;
	import flash.net.Responder;
	import flash.net.registerClassAlias;
	import flash.utils.getTimer;
	
	import jedai.events.Red5Event;
	import jedai.net.rpc.Red5Connection;
	import jedai.net.rpc.RemoteSharedObject;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;
	import org.papervision3d.core.math.Quaternion;	

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class AbstractSynchronisedScene extends EventDispatcher implements ISynchronisedScene
	{
		protected static const AVATAR_REMOTE_SO_KEY : String = "avatars";

		protected static const PAPERWORLD_SERVICE_PREFIX : String = "multiplayer";

		protected static const RECEIVE_INPUT_METHOD : String = PAPERWORLD_SERVICE_PREFIX + ".receiveInput";

		protected static const ADD_PLAYER_METHOD : String = PAPERWORLD_SERVICE_PREFIX + '.addPlayer';

		private static var logger:ILogger = LoggerFactory.getLogger("Paperworld");

		public var clientID : Number = -1;

		//protected var _context : CoreContext;

		public var sceneName : String;

		/**
		 * The 'point of view' object for Level of Detail heuristics - if no pov is defined then LOD will not be activated.
		 */
		public var pov : ISynchronisedAvatar;

		/**
		 * The list of avatars in this scene.
		 */
		public var avatars : ISynchronisedAvatar;

		public var avatarsByName : Array;

		public var player : Player;

		/**
		 * The list of Level of Detail heuristics used in this scene.
		 */
		public var lodConstraints : LodConstraint;

		protected var _avatarFactory : IAvatarFactory;

		public function set avatarFactory(value : IAvatarFactory) : void 
		{
			_avatarFactory = value;
		}

		protected var _connection : Red5Connection;	

		protected var _remoteSharedObject : RemoteSharedObject;

		protected var _userInput : IUserInput;

		public function set userInput(userInput : IUserInput) : void 
		{
			_userInput = userInput;
		}

		protected var _responder : Responder;

		public var time : int;

		/**
		 * Adds a LOD Heuristic to the list. Implicit setter used in order to allow heuristics to be set via prana.
		 */
		public function addLodConstraint(lc : LodConstraint) : void
		{
			lc.next = lodConstraints;
			lodConstraints = lc;
		}

		/**
		 * Constructor.
		 */
		public function AbstractSynchronisedScene()
		{
			super( );			
		}

		/**
		 * Initialise implementation - initialises linked lists.
		 */
		public function initialise() : void
		{			
			avatarsByName = new Array( );		
			
			//_context = CoreContext.getInstance( );
			
			registerClassAliases( );			
		}

		protected function registerClassAliases() : void 
		{
			registerClassAlias( 'com.brainfarm.java.data.State', State );
			registerClassAlias( 'com.brainfarm.java.util.math.Quaternion', Quaternion );
			registerClassAlias( 'com.brainfarm.java.util.math.Vector3', Vector3 );				
			registerClassAlias( 'com.paperworld.multiplayer.data.AvatarData', AvatarData );
			registerClassAlias( 'com.paperworld.multiplayer.data.SyncData', SyncData );	
		}

		public function connect(...args) : void
		{
			sceneName = String( args[0] );
			
			logger.info( "connecting to " + scene );

			//_connection = Red5Connection( _context.getObject( "connection" ) );
			_connection.objectEncoding = ObjectEncoding.AMF3;
						
			_connection.addEventListener( Red5Event.CONNECTED, onConnectionEstablished );
			_connection.addEventListener( Red5Event.DISCONNECTED, onConnectionDisconnected );
			
			_connection.client = this;
			
			_connection.connect( _connection.rtmpURI, _connection.clientManager.username, _connection.clientManager.password );
		}

		protected function onConnectionEstablished(event : Event) : void
		{
			//logger.info( "connection established" );

			dispatchEvent( new Event( RTMPEventTypes.CONNECTED_TO_SERVER ) );
			
			_remoteSharedObject = new RemoteSharedObject( AVATAR_REMOTE_SO_KEY, false, false, _connection );
			_remoteSharedObject.addEventListener( SyncEvent.SYNC, synchronise );
			
			_userInput.addEventListener( UserInputEvent.INPUT_CHANGED, onInputUpdate );
		}

		public function setClientID(val : Number) : void
		{
			if (clientID < 0)
			{
				//logger.info( "setting client id == " + val );

				clientID = val;	
			}
		}

		protected function onConnectionDisconnected(event : Event) : void
		{
			dispatchEvent( new Event( RTMPEventTypes.DISCONNECTED_FROM_SERVER ) );	
		}

		protected function syncAvatar(data : SyncData) : void 
		{ 
			var avatarData : AvatarData = data.avatarData;	
			
			var avatar : ISynchronisedAvatar = ISynchronisedAvatar( avatarsByName[avatarData.id] );
			
			if (avatar)
				avatar.synchronise( avatarData.time, avatarData.input, avatarData.state );
			else
				addAvatar( data );
		}

		protected function addAvatar(data : SyncData) : void 
		{			
			var avatarData : AvatarData = data.avatarData;
			
			var avatar : ISynchronisedAvatar = _avatarFactory.getAvatar( avatarData.getKey( ) );
			
			avatarsByName[avatarData.getId( )] = avatar;
			
			addRemoteChild( avatar.getSynchronisedObject( ), avatarData.getId( ) );
		}

		protected function handleDelete(id : String) : void
		{					
			removeRemoteChild( ISynchronisedAvatar( avatarsByName[id] ).getSynchronisedObject( ) );
		}

		protected function synchronise(event : SyncEvent) : void
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
						//logger.info( "changeList[" + i + "].code: " + changeList[i].code );
						syncAvatar( SyncData( _remoteSharedObject._so.data[name] ) );
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
						handleDelete( name );
						break;
							
					default:
						break;	
				}
			}
		}		

		public function onInputUpdate(event : UserInputEvent) : void
		{			
			time = getTimer( );
			_connection.call( RECEIVE_INPUT_METHOD, _responder, clientID, event.input );
		}

		
		public function addPlayer(player : Player, isLocal : Boolean = true) : void
		{
			//var avatar : ISynchronisedAvatar = ISynchronisedAvatar( _context.getObject( 'local.avatar' ) );

			//logger.info( "adding player avatar " + avatar );

			//if (isLocal) pov = avatar;
			
			//avatar.setNext( avatars );
			//avatars = avatar;
					
			//addRemoteChild( avatar.getSynchronisedObject( ), connector.id );

			//avatar.userInput = connector.input;
			//connector.addLagListener( avatar );

			//player.setAvatar( avatar );

			this.player = player;
			
			_connection.call( ADD_PLAYER_METHOD, new Responder( addPlayerResult, onStatus ), clientID );
		}

		public function addPlayerResult(avatar : AvatarData) : void
		{			
			logger.info( "adding player: " + avatar );
			addAvatar( new SyncData( 0, avatar ) );
		}

		public function onStatus(status : Object) : void
		{
			for (var i:String in status)
			{
				logger.info( "status: " + i + " " + status[i] );
			}
		}

		/**
		 * Add a simple object to the scene.
		 */
		public function addChild(child : *, name : String) : *
		{
			// Nothing here, implementation specific to a particular 3D engine in child classes.
			return child;
		}

		/**
		 * Adds an object to the scene that can be synchronised across clients.
		 * 
		 * @param child The object that will be synced across clients and added to the 3D scene.
		 * @param pov Flags whether or not this object should be used as the 'point of view' for the Level of Detail heuristics.
		 */
		public function addRemoteChild(child : ISynchronisedObject, name : String, isLocal : Boolean = false) : ISynchronisedObject
		{
			
			// Create a new Avatar to handle synchronisation.
			//var avatar : Avatar = new Avatar( );
			//avatar.syncObject = child;
			
			// Add this avatar to the local list.
			//avatar.next = avatars;
			//avatars = avatar;
			
			// If this SyncObject is the local player then set as pov.
			//if (pov) this.pov = avatar;
			
			// Finally, add the object to the 3D scene.
			var c : * = addChild( child, name );
			
			//logger.info( "adding remote child: " + c );

			return child;
		}

		public function removeChild(child : * ) : *
		{
			return null;
		}

		public function removeRemoteChild(child : ISynchronisedObject) : ISynchronisedObject
		{
			var previous : ISynchronisedAvatar;
			var next : ISynchronisedAvatar = avatars;
			
			// Loop through each avatar in the list.
			while (next)
			{			
				// When we find the avatar that's handling the child passed.	
				if (next.getSynchronisedObject( ) == child)
				{
					// Link the previous avatar with the next one - removing the current one from the list.
					previous.setNext( next.getNext( ) );
					next.destroy( );					
					break;	
				}	
				
				// Move to the next avatar in the list.
				previous = next;
				next = next.getNext( );				
			}	
			
			removeChild( child.displayObject );
			
			return child;
		}

		public function get scene() : *
		{
			return null;
		}

		public function set scene(value : *) : void
		{
		}
	}
}