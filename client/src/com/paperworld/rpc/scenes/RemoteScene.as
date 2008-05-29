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
		
		private var _connection:Red5Connection;
		
		private var _bootStrapper:Red5BootStrapper;

		public var _so : RemoteSharedObject;
				
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
			_players = new Array();
			
			addPlayerResponder = new Responder( addPlayerResponse );
		}
		
		public function addPlayer(player:RemotePlayer, isRemote:Boolean = true):void 
		{		
			_players[player.username] = player;
			player.avatar.name = player.username;
			
			if (isRemote)
			{
				_connection.call( PAPERWORLD_SERVICE_NAME + "." + CONNECT_TO_ZONE_METHOD, 
								  addPlayerResponder, 
								  player.username, 
								  _zone );
			}
			else
			{
				GameTimer.getInstance().addEventListener(IntegrationEvent.INTEGRATION_EVENT, player.avatar.update);
				
				addChild(player.avatar, player.username);
			}
		}
				
		public function addPlayerResponse(response:Object):void 
		{
			var array:Array = response as Array;
			var success:Boolean = array[0] as Boolean;
			var username:String = array[1] as String;
			
			if (success)
			{
				logger.info("Successfully added player " + username);
				
				var player:RemotePlayer = getPlayerByName(username);
				
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
			//logger.info(thisPlayer + " Syncing");
			
			var length : int = event.changeList.length;
			
			if (length > 0)
			{
				var so:SharedObject = _so._so;
			
				for (var j : int = 0; j < length ; j++)
				{
					var item : Object = event.changeList[j];
					var name : String = item["name"];
					var obj : Avatar;
					
					switch (item["code"])
					{
						case "clear":
							break;
	
						case "change":
																
							if (_players[name] != null)
							{
								getPlayerByName(name).avatar.synchronise( so.data[name] );
							}
							else
							{
								var player:RemotePlayer = new RemotePlayer();
								player.username = name;
								player.avatar = createPaperworldObject( so.data[name]["modelKey"], name );
								addPlayer(player, false);
							}
							
							break;
							
						case "delete":
						
							removeChild(getPlayerByName(name).avatar);
							_players[name] = null;
							break;
							
						default:
							break;
					}
				}
			}
		}

		private function createPaperworldObject(key : String, name : String) : Avatar 
		{						
			logger.info("trying to create: " + key + ", " + name);
			
			var ObjectClass : Class = getDefinitionByName( key ) as Class;
			var object : Avatar = new ObjectClass( ) as Avatar;
			object.name = name;
			
			object.setState(_so._so.data[name]);
			
			addChild( object, name );	
			
			return object;
		}
		
		public function getPlayerByName(name:String):RemotePlayer 
		{
			return _players[name] as RemotePlayer;
		}
	}
}
