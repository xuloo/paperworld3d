/*
 * --------------------------------------------------------------------------------------
 * PaperWorld3D - building better worlds
 * --------------------------------------------------------------------------------------
 * Realtime 3D Multi-User Application Framework for the Flash Platform.
 * --------------------------------------------------------------------------------------
 * Copyright (C) 2008 Influxis [http://www.influxis.com]
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
package com.paperworld.core.player;

import org.red5.server.api.IConnection;
import org.red5.server.api.IScope;
import org.red5.server.framework.Client;

import com.paperworld.core.avatar.Avatar;
import com.paperworld.core.avatar.AvatarInput;
import com.paperworld.scenes.RemoteScene;

/**
 * The Player object holds data about a client that is persistent across Rooms.
 * The input from a user is held in the Player along with username etc. etc.
 * Anything that isn't specific to a Room.
 * 
 * @author Trevor
 * 
 */
public class Player {
	/**
	 * Whether the Remote Shared Object used for Players is persistent or not
	 * (ie. whether it's held in a file by Red5 and is available after a restart
	 * of the server.
	 */
	// public static Boolean PERSISTENT = false;
	/**
	 * The user id for this Player. It's created and provided by Red5 when the
	 * user connects. It changes each time a Player reconnects.
	 */
	// private String uid;
	/**
	 * The Room this Player is currently in.
	 */
	// public Room room;
	/**
	 * The Player's username. Held seperately to the uid as it can be changed
	 * during a session.
	 */
	public String username;

	/**
	 * The current Avatar that's representing this player on the client and
	 * handling the input on the server-side.
	 */
	public Avatar avatar;

	/**
	 * The current time frame for this player. Each player can be at a different
	 * time relative to each other.
	 */
	public Integer time = 0;

	/**
	 * Flags whether this Player is currently active or not.
	 */
	// protected Boolean isActive = false;
	/**
	 * Flags whether this Player is currently connected or not (would be false
	 * if the client is currently reconnecting, for instance).
	 */
	// private boolean connected;
	/**
	 * The zone this player is currently in.
	 */
	private RemoteScene scene;

	private IConnection connection;
	
	private IScope scope;

	// private Client client;

	/**
	 * Constructor. Creates a Player with the uid passed.
	 * 
	 * @param uid
	 */
	/*
	 * public Player(String uid) { this.uid = uid; }
	 */
	
	private PlayerData playerData;

	public Player() {

	}

	/**
	 * Set the connected variable for this Player.
	 * 
	 * @param connected
	 */
	/*
	 * public void setConnected(boolean connected) { this.connected = connected; }
	 */

	/**
	 * Returns the current connected state for this Player.
	 * 
	 * @return
	 */
	/*
	 * public boolean getConnected() { return connected; }
	 */

	/**
	 * Called by the Application when Input data is received from a client. The
	 * Input is registered, passed to the Avatar and it's flagged as having
	 * changed to ensure that the Shared Object is updated on the next tick.
	 * 
	 * @param time
	 * @param input
	 */
	public void receiveInput(Integer time, AvatarInput input) {

		/*while (this.time < time) {
			avatar.update();
			this.time++;
		}*/

		avatar.setInput(input);
	}
	
	public void update(){
		avatar.update();
	}

	/**
	 * Returns the current active state of this Player.
	 * 
	 * @return
	 */
	/*
	 * public Boolean getIsActive() { return isActive; }
	 */

	/**
	 * Sets the current active state of this Player.
	 * 
	 * @param value
	 */
	/*
	 * public void setIsActive(Boolean value) { isActive = value; }
	 */

	/**
	 * Returns the current user id for this Player.
	 * 
	 * @return
	 */
	public String getUsername() {
		return username;
	}

	/**
	 * Sets the current user id for this Player. It's set initially when the
	 * user connects and then updated on each subsequent reconnection.
	 * 
	 * @param uid
	 */
	public void setUsername(String username) {
		this.username = username;
		avatar.id = username;
	}

	/**
	 * Sets the Avatar object for this Player.
	 * 
	 * @param avatar
	 */
	public void setAvatar(Avatar avatar) {
		this.avatar = avatar;
	}

	/**
	 * Returns the Avatar object for this Player.
	 * 
	 * @return
	 */
	public Avatar getAvatar() {
		return avatar;
	}

	public void setModelKey(String m) {
		// avatar.modelKey = m;
	}

	public AvatarInput getInput() {
		return avatar.getInput();
	}

	public RemoteScene getScene() {
		return scene;
	}

	public void setScene(RemoteScene scene) {
		this.scene = scene;
		/*if (scene != null) {
			avatar.setBehaviour(scene.getBehaviour());
		}*/
	}

	public void setConnection(IConnection connection) {
		this.connection = connection;
	}

	public IConnection getConnection() {
		return connection;
	}
	
	public PlayerData getPlayerData() {
		return new PlayerData(username, avatar.getThumbNail());
	}
	
	public void setScope(IScope scope) {
		this.scope = scope;
	}
	
	public IScope getScope() {
		return scope;
	}
}
