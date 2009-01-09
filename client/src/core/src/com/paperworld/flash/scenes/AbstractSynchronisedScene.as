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
package com.paperworld.flash.scenes 
{
	import com.actionengine.flash.core.EventDispatchingBaseClass;
	import com.actionengine.flash.core.context.CoreContext;
	import com.actionengine.flash.util.logging.Logger;
	import com.actionengine.flash.util.logging.LoggerContext;
	import com.brainfarm.flash.data.State;
	import com.brainfarm.flash.util.math.Quaternion;
	import com.brainfarm.flash.util.math.Vector3;
	import com.paperworld.api.ISynchronisedAvatar;
	import com.paperworld.api.ISynchronisedObject;
	import com.paperworld.api.ISynchronisedScene;
	import com.paperworld.flash.connectors.IConnector;
	import com.paperworld.flash.connectors.IConnectorListener;
	import com.paperworld.flash.connectors.ServerEventTypes;
	import com.paperworld.flash.connectors.events.ConnectorEvent;
	import com.paperworld.flash.data.SyncData;
	import com.paperworld.flash.lod.LodConstraint;
	import com.paperworld.flash.objects.AbstractSynchronisedAvatar;
	import com.paperworld.flash.player.Player;
	
	import flash.events.Event;
	import flash.net.registerClassAlias;		

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class AbstractSynchronisedScene extends EventDispatchingBaseClass implements ISynchronisedScene, IConnectorListener
	{
		private var logger : Logger;

		protected var _context : CoreContext;

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

		protected var _connector : IConnector;

		public function set connector(value : IConnector) : void
		{			
			_connector = value;
			_connector.addListener( this );
		}

		public function get connector() : IConnector
		{
			return _connector;
		}

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
		override public function initialise() : void
		{			
			logger = LoggerContext.getLogger( AbstractSynchronisedScene );
			
			avatarsByName = new Array( );		
			
			_context = CoreContext.getInstance( );
			
			registerClassAlias( 'com.brainfarm.java.util.math.Vector3', Vector3 );				registerClassAlias( 'com.paperworld.multiplayer.data.SyncData', SyncData );	
			registerClassAlias( 'com.brainfarm.java.data.State', State );
			registerClassAlias( 'com.brainfarm.java.util.math.Quaternion', Quaternion );
		}

		public function connect(...args) : void
		{
			sceneName = String(args[0]);
			
			logger.info( "connecting to " + scene );
			
			connector.connect( sceneName );			
		}

		protected function handleRemoteSync(data : Array) : void
		{									
			var avatar : ISynchronisedAvatar = ISynchronisedAvatar( avatarsByName[data[0]] );

			if (!avatar)
			{
				avatar = ISynchronisedAvatar( _context.getObject( 'remote.avatar' ) );
	
				logger.info(connector.id + " Handling new Avatar in scene " + data[0]);
	
				avatar.setInput( data[2] );
				avatar.setState( data[3] );
				avatar.setTime( data[1] );
				
				addRemoteChild( avatar.getSynchronisedObject( ) );
				
				avatarsByName[data[0]] = avatar;
			}

			logger.info("Updating " + (player.getAvatar( ) == avatar) + " " + (player.getAvatar( ).getSynchronisedObject() == avatar.getSynchronisedObject()));

			avatar.synchronise( data[1], data[2], data[3] );	
		}

		protected function handleLocalSync(data : Array) : void
		{
			player.getAvatar( ).synchronise( data[1], data[2], data[3] );
		}

		protected function handleDelete(data : Array) : void
		{
			var avatar : AbstractSynchronisedAvatar = AbstractSynchronisedAvatar( avatarsByName[data[0]] );
			removeRemoteChild( avatar.getSynchronisedObject( ) );
		}

		public function onConnectorEvent(event : ConnectorEvent) : void
		{			
			var data : Array = event.data;
			
			switch (event.type)
			{
				case ServerEventTypes.LOCAL_AVATAR_SYNC:
					handleLocalSync( data );
					break;
					
				case ServerEventTypes.REMOTE_AVATAR_SYNC:
					handleRemoteSync( data );
					break;
					
				case ServerEventTypes.AVATAR_DELETE:
					handleDelete( data );
					break;
			}
		}

		
		public function addPlayer(player : Player, isLocal : Boolean = true) : void
		{
			var avatar : ISynchronisedAvatar = ISynchronisedAvatar( _context.getObject( 'local.avatar' ) );

			logger.info( "adding player avatar " + avatar );

			if (isLocal) pov = avatar;
			
			avatar.setNext( avatars );
			avatars = avatar;
					
			addRemoteChild( avatar.getSynchronisedObject( ) );

			avatar.userInput = connector.input;
			//connector.addLagListener( avatar );

			player.setAvatar( avatar );
			
			this.player = player;
			
			connector.addPlayer( player );
		}

		/**
		 * Add a simple object to the scene.
		 */
		public function addChild(child : *) : *
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
		public function addRemoteChild(child : ISynchronisedObject, isLocal : Boolean = false) : ISynchronisedObject
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
			var c:* = addChild( child );
			
			logger.info( "adding remote child: " + c );
			
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