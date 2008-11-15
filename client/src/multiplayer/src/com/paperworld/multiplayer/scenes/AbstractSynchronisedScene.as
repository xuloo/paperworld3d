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
package com.paperworld.multiplayer.scenes 
{
	import flash.events.Event;
	import flash.net.registerClassAlias;
	
	import com.actionengine.flash.core.context.ContextLoader;
	import com.actionengine.flash.util.logging.Logger;
	import com.actionengine.flash.util.logging.LoggerContext;
	import com.brainfarm.flash.util.math.Vector3;
	import com.paperworld.multiplayer.connectors.ConnectorListener;
	import com.paperworld.multiplayer.connectors.RTMPConnector;
	import com.paperworld.multiplayer.data.SyncData;
	import com.paperworld.multiplayer.events.ServerSyncEvent;
	import com.paperworld.multiplayer.lod.LodConstraint;
	import com.paperworld.multiplayer.objects.Client;
	import com.paperworld.multiplayer.objects.SyncObject;
	import com.paperworld.multiplayer.player.Player;
	import com.paperworld.util.Synchronizable;		

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class AbstractSynchronisedScene extends ContextLoader implements ConnectorListener
	{
		private var logger : Logger = LoggerContext.getLogger( AbstractSynchronisedScene );

		/**
		 * The Clock instance used as a timer for this scene.
		 */
		//public var clock : Clock;

		public var sceneName : String;

		/**
		 * The 'point of view' object for Level of Detail heuristics - if no pov is defined then LOD will not be activated.
		 */
		public var pov : SyncObject;

		/**
		 * The list of avatars in this scene.
		 */
		public var avatars : SyncObject;

		public var avatarsByName : Array;

		public var player : Player;

		/**
		 * The list of Level of Detail heuristics used in this scene.
		 */
		public var lodConstraints : LodConstraint;

		protected var _connector : RTMPConnector;

		public function set connector(value : RTMPConnector) : void
		{			
			_connector = value;
			_connector.addListener( this );
		}

		public function get connector() : RTMPConnector
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
			avatarsByName = new Array( );		
			
			registerClassAlias( 'com.paperworld.core.math.Vector3', Vector3 );				registerClassAlias( 'com.paperworld.multiplayer.data.SyncData', SyncData );	
		}

		public function connect(scene : String, context : String = "multiplayerContext.xml") : void
		{
			sceneName = scene;
			
			loadContext( context );				
		}

		override protected function onContextLoaded(event : Event) : void
		{
			super.onContextLoaded( event );

			connector.connect( sceneName );
		}

		public function onRemoteSync(event : ServerSyncEvent) : void
		{			
			var avatar : SyncObject = SyncObject( avatarsByName[event.id] );

			if (!avatar)
			{
				avatar = SyncObject( _applicationContext.getObject( 'remote.avatar' ) );
	
				avatar.input = event.input;
				avatar.state = event.state;
				avatar.time = event.time;
				
				addRemoteChild( avatar.displayObject );
				
				avatarsByName[event.id] = avatar;
			}

			avatar.synchronise( event );	
		}

		public function onLocalSync(event : ServerSyncEvent) : void
		{
			player.avatar.synchronise( event );
		}

		public function onDelete(event : ServerSyncEvent) : void
		{
			var avatar : SyncObject = SyncObject( avatarsByName[event.id] );
			removeRemoteChild( avatar.displayObject );
		}

		
		public function addPlayer(player : Player, isLocal : Boolean = true) : void
		{
			var avatar : Client = Client( _applicationContext.getObject( 'local.avatar' ) );

			if (isLocal) pov = avatar;
			
			avatar.next = avatars;
			avatars = avatar;
					
			//avatarsByName[connector.clientID] = avatar;
			addRemoteChild( avatar.displayObject );

			avatar.userInput = connector.input;
			connector.addLagListener( avatar );
			
			player.avatar = avatar;
			
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
		public function addRemoteChild(child : Synchronizable, pov : Boolean = false) : Synchronizable
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
			addChild( child );
			
			return child;
		}

		public function removeChild(child : * ) : *
		{
			return child;
		}

		public function removeRemoteChild(child : Synchronizable) : Synchronizable
		{
			var previous : SyncObject;
			var next : SyncObject = avatars;
			
			// Loop through each avatar in the list.
			while (next)
			{			
				// When we find the avatar that's handling the child passed.	
				if (next.displayObject == child)
				{
					// Link the previous avatar with the next one - removing the current one from the list.
					previous.next = next.next;
					next.destroy( );					
					break;	
				}	
				
				// Move to the next avatar in the list.
				previous = next;
				next = SyncObject( next.next );				
			}	
			
			removeChild( child.getObject( ) );
			
			return child;
		}
	}
}

