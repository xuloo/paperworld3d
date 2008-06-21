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
package com.paperworld.rpc.player 
{
	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.rpc.input.AbstractUserInput;
	import com.paperworld.rpc.input.IUserInput;
	import com.paperworld.rpc.input.KeyboardInput;
	import com.paperworld.rpc.objects.Avatar;
	import com.paperworld.rpc.timer.GameTimer;
	import com.paperworld.rpc.timer.events.IntegrationEvent;
	
	import flash.net.Responder;
	
	import jedai.Red5BootStrapper;
	import jedai.net.ClientManager;
	import jedai.net.rpc.Red5Connection;
	
	public class RemotePlayer /*extends ClientManager*/
	{		
		public static var TESTER:int = 0;
		
		public var $connection : Red5Connection;

		public var userInput : AbstractUserInput;

		public var inputResponder : Responder;
		
		private var syncInterval:int = 3;
		
		private var syncCount:int = 0;
		
		private var logger:XrayLog = new XrayLog();
		
		private var _client:ClientManager;
		
		private var _avatar:Avatar;
		
		public function set client(value:ClientManager):void 
		{
			_client = value;
		}
		
		public function get username():String
		{
			return _client.username;
		}
		
		public function set username(value:String):void 
		{
			logger.info("Setting player username " + _client.username + " to " + value);
			_client.username = value;
		}

		public function set connection(value : Red5Connection) : void
		{
			$connection = value;
		}
		
		public function get connection():Red5Connection
		{
			return $connection;
		}
		
		public function set avatar(value:Avatar):void 
		{
			_avatar = value;
			GameTimer.getInstance().addEventListener(IntegrationEvent.INTEGRATION_EVENT, _avatar.update);
		}
		
		public function get avatar():Avatar
		{
			return _avatar;
		}

		/**
		 * The singleton instance of this class.
		 */
		private static var $instance : RemotePlayer;

		/**
		 * Constructor, private to prevent instantiation.
		 * Always set the default currency symbol - this will be over-ridden
		 * by genuine currencies if available.
		 */
		public function RemotePlayer( onlyPlayer:Boolean = true )
		{
			super( );

			//username = createUniqueName( );
			
			//_client = (onlyPlayer) ? Red5BootStrapper.getInstance().client : new ClientManager();
			_client = new ClientManager();
			_client.username = Red5BootStrapper.getInstance().client.username;
			_client.password = Red5BootStrapper.getInstance().client.password;
			logger.info("creating Player :: " + _client.username);
			
			inputResponder = new Responder( inputResponse );
			
			userInput = new KeyboardInput( );
			GameTimer.getInstance( ).input = userInput;			
			
			GameTimer.getInstance().addEventListener(IntegrationEvent.INTEGRATION_EVENT, handleInput);
		}

		/**
		 * Return an instance of this class.
		 *//*
		public static function getInstance() : Player
		{
			if ($instance == null)
			{
				$instance = new Player( new Singleton() );
			}

			return $instance;
		}	*/

		/**
		 * Does this user have a valid chat name?
		 */
		public function hasValidUsername() : Boolean
		{
			if ( username.length == 0 || username == null )
				return false;
		
			return true;
		}

		public function createUniqueName() : String 
		{
			// Set the timeDate stamp.
			var currentDate : Date = new Date( );
			return String( currentDate.getFullYear( ) ) + String( currentDate.getMonth( ) ) + String( currentDate.getDay( ) ) + String( currentDate.getHours( ) ) + String( currentDate.getMinutes( ) ) + String( currentDate.getMilliseconds( ) );
		}

		public function inputResponse(obj : Object) : void
		{
		}

		/**
		 * triggered by a 'integration' event from the game timer. 
		 * this method needs to check how much time has passed since it last sent a batch of moves to the server.
		 * If sufficient time has passed then we need to get hold of the moves that have been executed since the last 
		 * batch that was sent. 
		 * Otherwise it just creates a new move and stores it in the character's History.
		 */
		public function handleInput(event : IntegrationEvent) : void 
		{					
			var userInput : IUserInput = event.input;
						
			if (userInput.hasChanged && _avatar)
			{			
				//logger.info("handling input :: " + username);
				
				_avatar.character.input.left = userInput.left;
				_avatar.character.input.right = userInput.right;
				_avatar.character.input.forward = userInput.forward;
				_avatar.character.input.back = userInput.backward;
				_avatar.character.input.up = userInput.K;
				_avatar.character.input.down = userInput.M;
				_avatar.character.input.firing = userInput.space;
				_avatar.character.input.yawNegative = userInput.right;
				_avatar.character.input.yawPositive = userInput.left;
				_avatar.character.input.pitchNegative = userInput.up;
				_avatar.character.input.pitchPositive = userInput.down;
				_avatar.character.input.rollNegative = userInput.ONE;
				_avatar.character.input.rollPositive = userInput.TWO;
				_avatar.character.input.mouseX = userInput.mouseX;
				_avatar.character.input.mouseY = userInput.mouseY;

				logger.info("left: " + _avatar.character.input.left + " right: " + _avatar.character.input.right);

				if($connection)
				{			
					$connection.call( "paperworld.handleInput", inputResponder, username, _avatar.character.time, _avatar.character.input.left, _avatar.character.input.right, _avatar.character.input.forward, _avatar.character.input.back, _avatar.character.input.up, _avatar.character.input.down, _avatar.character.input.yawNegative, _avatar.character.input.yawPositive, _avatar.character.input.pitchNegative, _avatar.character.input.pitchPositive, _avatar.character.input.rollNegative, _avatar.character.input.rollPositive, _avatar.character.input.mouseX, _avatar.character.input.mouseY, _avatar.character.input.firing );
				}
				
				userInput.hasChanged = false;
			}
		}
	}
}

class Singleton{}