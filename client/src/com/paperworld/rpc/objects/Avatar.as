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
package com.paperworld.rpc.objects 
{
	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.rpc.data.AvatarInput;
	import com.paperworld.rpc.data.AvatarState;
	import com.paperworld.rpc.input.Move;
	import com.paperworld.rpc.timer.events.IntegrationEvent;
	import com.paperworld.rpc.util.History;
	
	import org.papervision3d.core.math.Matrix3D;
	import org.papervision3d.core.math.Number3D;
	import org.papervision3d.core.math.Quaternion;
	import org.papervision3d.objects.DisplayObject3D;	
	/**
	 * <p><code>Avatar</code> handles syncing an object on a client with it's duplicate on the server.</p>
	 * 
	 * <p>By keeping a set of 3 objects the <code>Avatar</code> can handle keeping in sync with the server while
	 * smoothing out any jitter in the receipt of updates from the server.</p>
	 * 
	 * <ul>
	 * 		<li><i>Proxy</i> - is a direct representation of the data recieved from the server. When an update is receive the 
	 * 							Proxy is 'snapped' instantly to that state.
	 * 		</li>
	 * 		<li><i>Character</i> - represents the result of the user's input. This object is directly manipulated by UserInput.
	 * 		</li>
	 * 		<li><i>Avatar</i> - is a result of smoothing the Character towards the Proxy. This Avatar object is the smoothed towards the Character.
	 * 		</li>
	 * 	</ul>
	 * 	
	 * 	<p>This object listens to the <code>GameTimer</code> and updates each of the 3 objects on each tick it receives.</p>
	 * 	
	 * 	<p>It also listens to the <code>RemoteScene</code> that it's a part of. When server updates are received and passed to it the Avatar:</p>
	 * 	
	 * 	<ul>
	 * 		<li>Synchronises the Proxy</li>
	 * 		<li>Smooths the Character towards the Proxy</li>
	 * 		<li>Smooths the Avatar towards the Character</li>
	 * 		<li>Corrects the history of moves recorded for this Avatar, ensuring that 
	 * 		playback results in the user seeing a replica of the server's view of events</li>
	 * 	</ul>
	 * 
	 * @author Trevor
	 */
	public class Avatar extends DisplayObject3D 
	{
		public var time : int = 0;

		/**
		 * <p>The modelKey is a reference to the name of the model used to represent this object in the scene.
		 * It should be the same name as that used to reference the model in the module config file if you're
		 * using the full framework, or the name of the custom model if you're just using the RPC library.</p>
		 * 
		 * <p>The key is passed to the server and stored for this object - then passed to all the other clients (as well as those
		 * that connect to the scene in future) allowing them to create the correct object in their local scenes.</p>
		 */
		public var modelKey : String;

		public var uid : String;

		public var proxy : Proxy;

		public var character : RemoteObject;

		public var avatar : RemoteObject;
		
		public var updating : Boolean = false;

		protected var inScene : Boolean = false;

		protected var history : History;

		public var lastSyncTime : int = 0;

		public var registered : Boolean = true;

		public var behaviour : IAvatarBehaviour;

		/**
		 * Local state object. The state data received from the server is packed into this object
		 * before being passed to the Proxy and Character objects to avoid having to create a 
		 * 'new' object each time an event is received.
		 */
		private var state : AvatarState;

		private var input : AvatarInput;
		
		private var logger:XrayLog = new XrayLog();

		public function Avatar()
		{
			super( );
			
			initialise();
		}
		
		protected function initialise():void 
		{
			state = new AvatarState( );
			input = new AvatarInput( );
			
			createCharacter();
			createProxy();			
			
			history = new History( );
		}
		
		protected function createCharacter():void 
		{
			character = new RemoteObject( new DisplayObject3D( ) );
		}
		
		protected function createProxy():void 
		{
			proxy = new Proxy( new DisplayObject3D() );
		}

		public function destroy() : void 
		{
			time = 0;
			modelKey = null;
			uid = null;
			
			updating = false;
			inScene = false;
			lastSyncTime = 0;
			registered = false;
			
			history.destroy( );
			history = null;
			
			behaviour.destroy( );
			behaviour = null;
			
			proxy.destroy( );
			proxy = null;
			
			character.destroy( );
			character = null;
			
			avatar.destroy( );
			avatar = null;			
		}

		protected function createDisplayObject(key : String) : void 
		{
		}

		public function set displayObject(value : RemoteObject) : void 
		{
			character = value;
		}

		public function update(event : IntegrationEvent) : void 
		{						
			var move : Move = new Move( );
			move.time = time;
			move.state = proxy.current.copy( );
			move.input = character.input.copy( );
			
			//history.add( move );	
			
			character.update( event.time, behaviour );
			proxy.update( event.time, behaviour );
			
			time++;
		
			character.smooth( proxy, character.tightness );
			
			if (name == "bbb")
				logger.info("\ncharacter\n" + character.current + "\nproxy\n" + proxy.current);

			avatar.smooth( character, avatar.tightness );

			avatar.displayObject.transform.copy(avatar.current.transform);
		}

		public function synchronise(data : Object) : void 
		{	
			logger.info("Synchronsing " + this.name);
			
			if (data["input"] != null)
			{
				// Get the State data.
				if (data["state"] != null)
				{
					var stateData : Object = data["state"];
					state.transform.n11 = stateData["n11"];
					state.transform.n12 = stateData["n12"];
					state.transform.n13 = stateData["n13"];
					state.transform.n14 = stateData["n14"];
					state.transform.n21 = stateData["n21"];
					state.transform.n22 = stateData["n22"];
					state.transform.n23 = stateData["n23"];
					state.transform.n24 = stateData["n24"];
					state.transform.n31 = stateData["n31"];
					state.transform.n32 = stateData["n32"];
					state.transform.n33 = stateData["n33"];
					state.transform.n34 = stateData["n34"];
					state.transform.n41 = stateData["n41"];
					state.transform.n42 = stateData["n42"];
					state.transform.n43 = stateData["n43"];
					state.transform.n44 = stateData["n44"];
					
					state.orientation.x = stateData["qx"];
					state.orientation.y = stateData["qy"];
					state.orientation.z = stateData["qz"];
					state.orientation.w = stateData["qw"];
					
					state.position.x = stateData["px"];
					state.position.y = stateData["py"];
					state.position.z = stateData["pz"];
					
					state.speed = stateData["speed"];
				}
				else
				{
					state = new AvatarState( );
				}
				
				// Get the Input data.				
				var inputData : Object = data["input"];
				input.back = inputData["back"];
				input.forward = inputData["forward"];
				input.down = inputData["down"];
				input.firing = inputData["firing"];
				input.left = inputData["left"];
				input.mouseX = inputData["mouseX"];
				input.mouseY = inputData["mouseY"];
				input.pitchNegative = inputData["pitchNegative"];
				input.pitchPositive = inputData["pitchPositive"];
				input.right = inputData["right"];
				input.rollNegative = inputData["rollNegative"];
				input.rollPositive = inputData["rollPositive"];
				input.up = inputData["up"];
				input.yawNegative = inputData["yawNegative"];
				input.yawPositive = inputData["yawPositive"];
				
				var t : int = data["time"];

				proxy.synchronise( t, state, input );
				character.synchronise( t, state, input );
			}
		}

		public function setState( data : Object ) : void 
		{
			var state : AvatarState = new AvatarState( );
			var stateData : Object = data["state"];
			state.transform.n11 = stateData["n11"];
			state.transform.n12 = stateData["n12"];
			state.transform.n13 = stateData["n13"];
			state.transform.n14 = stateData["n14"];
			state.transform.n21 = stateData["n21"];
			state.transform.n22 = stateData["n22"];
			state.transform.n23 = stateData["n23"];
			state.transform.n24 = stateData["n24"];
			state.transform.n31 = stateData["n31"];
			state.transform.n32 = stateData["n32"];
			state.transform.n33 = stateData["n33"];
			state.transform.n34 = stateData["n34"];
			state.transform.n41 = stateData["n41"];
			state.transform.n42 = stateData["n42"];
			state.transform.n43 = stateData["n43"];
			state.transform.n44 = stateData["n44"];					
			state.orientation.x = stateData["qx"];
			state.orientation.y = stateData["qy"];
			state.orientation.z = stateData["qz"];
			state.orientation.w = stateData["qw"];					
			state.position.x = stateData["px"];
			state.position.y = stateData["py"];
			state.position.z = stateData["pz"];					
			state.speed = stateData["speed"];
			
			proxy.setState( state );
			character.setState( state );
			avatar.setState( state );
		}

		public function getStateFromObject(obj : Object) : AvatarState
		{
			var state : AvatarState = new AvatarState( );
			
			if (obj != null)
			{
				state.transform = new Matrix3D( new Array( obj.n11, obj.n12, obj.n13, obj.n14, obj.n21, obj.n22, obj.n23, obj.n24, obj.n31, obj.n32, obj.n33, obj.n34, obj.n41, obj.n42, obj.n43, obj.n44 ) );
															 
				state.orientation = new Quaternion( obj.qx, obj.qy, obj.qz, obj.qw );
				state.position = new Number3D( obj.px, obj.py, obj.pz );
				state.speed = obj.speed;
			}
			
			return state;
		}

		public function getInputFromObject(obj : Object) : AvatarInput
		{
			var input : AvatarInput = new AvatarInput( );
			
			input.back = obj["back"];
			input.forward = obj["forward"];
			input.down = obj["down"];
			input.firing = obj["firing"];
			input.left = obj["left"];
			input.mouseX = obj["mouseX"];
			input.mouseY = obj["mouseY"];
			input.pitchNegative = obj["pitchNegative"];
			input.pitchPositive = obj["pitchPositive"];
			input.right = obj["right"];
			input.rollNegative = obj["rollNegative"];
			input.rollPositive = obj["rollPositive"];
			input.up = obj["up"];
			input.yawNegative = obj["yawNegative"];
			input.yawPositive = obj["yawPositive"];
			
			return input;
		}
	}
}
