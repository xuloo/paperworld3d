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
package com.paperworld.rpc.scenes 
{
	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.rpc.objects.Avatar;
	import com.paperworld.rpc.player.RemotePlayer;
	import com.paperworld.rpc.timer.GameTimer;
	import com.paperworld.rpc.timer.events.IntegrationEvent;
	
	import flash.events.Event;
	import flash.events.SyncEvent;
	import flash.net.Responder;
	import flash.net.SharedObject;
	import flash.utils.getDefinitionByName;
	
	import jedai.Red5BootStrapper;
	import jedai.events.Red5Event;
	import jedai.net.rpc.Red5Connection;
	import jedai.net.rpc.RemoteSharedObject;
	
	import org.papervision3d.scenes.Scene3D;	

	/**
	 * <p>Handles synchronisation of a <i>local</i> and a <i>remote</i> scene.</p> 
	 * 
	 * <p>When an object is added to a <code>RemoteScene</code> on the server it's <i>local</i> counterpart on each client is 
	 * informed about the event and each client creates an instance of the correct object and adds it to itself. Each object
	 * is then kept synchronised with its <i>remote</p> counterpart through the <code>RemoteScene</code>.</p>
	 * 
	 * @author Trevor
	 */
	public class RemoteScene extends Scene3D
	{
		public static const PAPERWORLD_SERVICE_NAME:String = "paperworld";
		public static const CONNECT_TO_ZONE_METHOD:String = "connectToZone";
		//private static var ID_LIST : Array = new Array( );
		
		private var _connection:Red5Connection;
		
		private var _bootStrapper:Red5BootStrapper;

		//public var playerRegistered : Boolean = false;

		//private var $roomId : String;

		public var objectQueue : Array;
		
		private var _avatars:Array;

		public var _so : RemoteSharedObject;
		
		//public var _so:SharedObject;

		//public var inScene : Boolean = false;
		
		private var _players:Array;
		
		private var addPlayerResponder:Responder;
		
		/**
		 * The Zone on the server that this Scene will be a representation of.
		 */
		private var _zone:String;
		
		public function get zone():String 
		{
			return _zone;
		}
		
		public function set zone(value:String):void 
		{			
			_zone = value;
			logger.info("SEtting zone in scene: " + value + ", " + _zone);
		}
		
		private var logger:XrayLog = new XrayLog();


		
		public function get connection():Red5Connection
		{
			return _connection;
		}

		public function RemoteScene(zone:String = null)
		{
			super( );

			_zone = zone;
			
			objectQueue = new Array( );
			_players = new Array();
			_avatars = new Array();
			
			addPlayerResponder = new Responder( addPlayerResponse );
		}
		
		public function addPlayer(player:RemotePlayer):void 
		{		
			_connection.call( PAPERWORLD_SERVICE_NAME + "." + CONNECT_TO_ZONE_METHOD, 
							  addPlayerResponder, 
							  player.username, 
							  _zone );
			
			_players[player.username] = player;
		}
		
		public function addPlayerResponse(response:Object):void 
		{
			var array:Array = response as Array;
			var success:Boolean = array[0] as Boolean;
			var username:String = array[1] as String;
			
			if (success)
			{
				logger.info("Successfully added player " + username);
				
				var player:RemotePlayer = _players[username] as RemotePlayer;
				
				player.connection = Red5BootStrapper.getInstance().connection;
				
				GameTimer.getInstance().addEventListener(IntegrationEvent.INTEGRATION_EVENT, player.avatar.update);
				GameTimer.getInstance().addEventListener(IntegrationEvent.INTEGRATION_EVENT, player.handleInput);
			
				super.addChild(player.avatar, username);
			}
			else
			{
				logger.info("Adding player unsuccesful... removing");
				_players[username] = null;
			}
		}
		
		public function connect():void 
		{
			var _bootStrapper:Red5BootStrapper = Red5BootStrapper.getInstance();
			_connection = _bootStrapper.connection;
			
			createRoomSO();
			addQueuedObjectsToScene();
			
			/*if (_bootStrapper)
			{
				_bootStrapper.connect();
			}
			else
			{
				createConnection();
			}*/
		}

		/**
		 * No connector was passed to the constructor so we need to create one.
		 * If no id was passed to the constructor we need to find the next available one.
		 * The constructor we create (if one isn't already available for the room id) is
		 * placed in that slot so that room can't be connected to again by accident.
		 */
		public function createConnection() : void
		{
			logger.info("Creating Connection");
			
			_bootStrapper = Red5BootStrapper.getInstance();
			_bootStrapper.addEventListener("bootStrapComplete", onBootstrapComplete);
			_bootStrapper.addEventListener(Red5Event.CONNECTED, onConnected);
		}
		
		public function onBootstrapComplete(event:Event):void 
		{
			logger.info("bootstrap complete... connecting " + _bootStrapper.connection);
			
			_connection = _bootStrapper.connection;		
			
			_bootStrapper.connect();
			
			dispatchEvent(event.clone());
		}

		/**
		 * <p>This callback method is called when this <i>local</i> <code>RemoteScene</code> has successfully connected to
		 * it's <i>remote</i> counterpart on the server.</p>
		 * 
		 * <p>A <code>PlayerManager</code> instance is created to handle the list of players connected to the same scene.</p>
		 * 
		 * <p>Both the <code>PlayerManager</code> and the <code>RemoteScene</code> instances are connected to the Remote Shared Objects 
		 * on the server.</p>
		 */
		private function connectionHandler(obj : Object) : void 
		{
			//createRoomSO( $connector );		
			
			//inScene = true;
			//registerObjects();
			addQueuedObjectsToScene( );
		}

		/**
		 * <p>Handles connecting to the <code>RemoteScene</code>'s <i>remote</i> counterpart on the server.</p>
		 * 
		 * <p>If no <code>roomId</p> has been set then we connect to the next available number to make sure there's no collision
		 * with other <code>roomId</code> for other <code>RemoteScene</code> instances that may be available.</p>
		 */
		public function onConnected(event : Red5Event) : void 
		{					
			createRoomSO();
			
			dispatchEvent(event);			
			//_player.client = _bootStrapper.client;	

			//_connection.call( "paperworld.connectToZone", new Responder( connectionHandler ), _player.username, "spacezone" );		
		}

		/**
		 * Check if this scene contains a <code>PaperworldObject</code> with the name supplied.
		 */
		public function containsObject(id : String) : Boolean
		{
			for (var i : int = 0; i < objects.length ; i++)
			{
				if (objects[i] is Avatar)
				{
					var	object : Avatar = objects[i] as Avatar;
					
					if (object.name == id)
					{
						return true;
					}
				}
			}
			
			return false;
		}

		/**
		 * Connects to the Remote Shared Object on the server that contains the data about this scene.
		 */
		public function createRoomSO() : void 
		{
			logger.info("Connecting to zone: " + _zone);
			
			_so = new RemoteSharedObject(_zone, false, false, _connection);
			_so.addEventListener(SyncEvent.SYNC, onSync);	
		}

		/**
		 * <p>Receives a SYNC event from the Remote Shared Object that contains the details of the 
		 * objects in the scene.</p>
		 * 
		 * <p>If the object that has changed doesn't already exist in the scene, then it's created and inserted
		 * into the scene. If it already exists then the new data is pushed through to the object's <code>synchronise()</code>
		 * method in order for it to sync with the server</p>
		 * 
		 * <p>This process means that the <code>PaperworldObject</code> instances know nothing about the Shared Objects
		 * on the server. This is currently due to an issue in Red5 that prevents the same client connecting to 
		 * the same Remote Shared Object. So we have to have a single point of contact - this is probably a good thing
		 * as having several SYNC handlers being called on the same client several times a second is the best
		 * way to crash the browser. It also means that the <code>PaperworldObject</code> instances can be 
		 * synchronised from other sources if necessary (i'm not sure how this could be useful at this point in time
		 * but it's always nice to have the option!)</p>
		 */
		public function onSync(event : SyncEvent) : void 
		{				
			//logger.info("Syncing " + _zone);
			
			var length : int = event.changeList.length;
			
			if (length > 0)
			{
				var so:SharedObject = _so._so;
			
				for (var j : int = 0; j < length ; j++)
				{
					var item : Object = event.changeList[j];
					var name : String = item["name"];
					var obj : Avatar;
					
					//logger.info("code :: " + item["code"]);
					
					switch (item["code"])
					{
						case "clear":
/*
								for (var i:String in so.data)
								{
									logger.info("Creating new player: " + so.data[i]["name"]);
									var player:RemotePlayer = new RemotePlayer();
									player.avatar = createPaperworldObject( so.data[i]["modelKey"], i );
									_players[so.data[i]["name"]] = player;
									//createPaperworldObject( so.data[i]["modelKey"], i );
								}
							*/
							break;
	
						case "change":
								
							if (_players[name] != null)
							{
								(_players[name] as RemotePlayer).avatar.synchronise( so.data[name] );
							}
							else
							{
								var player:RemotePlayer = new RemotePlayer();
								player.avatar = createPaperworldObject( so.data[name]["modelKey"], name );
								_players[name] = player;
							}
							
							break;
							
						case "delete":
						
							obj = getChildByName( name ) as Avatar;
							
							if (obj != null)
							{
								obj.destroy();
								removeChild(obj);
							}
							break;
						default:
							break;
					}
				}
			}
		}

		private function createPaperworldObject(key : String, name : String) : Avatar 
		{						
			logger.info("trying to create: " + key);
			
			var ObjectClass : Class = getDefinitionByName( key ) as Class;
			var object : Avatar = new ObjectClass( ) as Avatar;
			object.name = name;
			
			object.setState(_so._so.data[name]);
			
			_avatars.push(object);
			super.addChild( object, name );	
			
			return object;
		}
/*
		public override function addChild( child : DisplayObject3D, name : String = null ) : DisplayObject3D
		{						
			logger.info("Adding Child");
			
			if (child is Avatar)
			{
				logger.info("Child is an avatar");
				if (_connection.connected)
				{
					_avatars.push(child);
				}
				else
				{
					logger.info("putting into queue");
					objectQueue.push( child );
				}
			}
			
			return super.addChild( child, name );
		}*/

		/**
		 * If a <code>PaperworldObject</code> is added to this scene before it's connected to its <i>remote</i> counterpart then 
		 * it's added to the <code>objectQueue</code>. When a successful connection is established, this queue of objects are then added
		 * to the scene.
		 */
		private function addQueuedObjectsToScene() : void 
		{
			if (objectQueue.length > 0)
			{
				for (var i : int = 0; i < objectQueue.length ; i++)
				{
					var object : Avatar = objectQueue[i] as Avatar;
					//object.registered = true;
					addChild( object, object.name );
				}
			}
		}	
		/*
		private function registerObjects():void 
		{
			for (var i:int = 0; i < objects.length; i++)
			{
				if (objects[i] is Avatar)
				{
					(objects[i] as Avatar).registered = true;
				}	
			}
		}*/

		public function addingObjectHandler(obj : Object) : void 
		{
		}
		
		public function getPlayerByName(name:String):RemotePlayer 
		{
			return _players[name] as RemotePlayer;
		}
/*
		public function addRemoteObject(key : String, id : String) : void 
		{
			logger.info( "Adding remote object\n" + key + "\n" + id + " == " + GamePlayer.getInstance( ).uid );
			
			if (!containsObject( id ))
			{
				var remoteObject : PaperworldObject = new PaperworldObject( );
				remoteObject.name = id;
				
				//remoteObject.setSharedObject($connection.connection);

				addChild( remoteObject, id );
			}
		}

		public function removeRemoteObject(uid : String) : void 
		{
			logger.info( "Removing " + uid );
			
			var remoteObject : PaperworldObject = getChildByName( uid ) as PaperworldObject;
			removeChild( remoteObject );
		}*/
	}
}
