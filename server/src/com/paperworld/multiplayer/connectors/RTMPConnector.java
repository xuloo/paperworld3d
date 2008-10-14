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
package com.paperworld.multiplayer.connectors;

import org.red5.server.api.IConnection;
import org.red5.server.api.IScope;
import org.red5.server.api.ScopeUtils;
import org.red5.server.api.so.ISharedObject;
import org.red5.server.api.so.ISharedObjectService;

import com.paperworld.ai.steering.Kinematic;
import com.paperworld.multiplayer.data.SyncData;
import com.paperworld.multiplayer.data.TimedInput;
import com.paperworld.multiplayer.jobs.UpdateAvatarsJob;
import com.paperworld.multiplayer.jobs.UpdateSharedObjectJob;
import com.paperworld.multiplayer.objects.Avatar;
import com.paperworld.multiplayer.player.Player;

public class RTMPConnector extends AbstractConnector {

	public int time = 0;

	protected String avatarUpdateJob;

	protected String sharedObjectUpdateJob;

	public RTMPConnector() {
		super();
	}

	protected void createScheduledJobs() {

		System.out.println("Starting scheduled jobs " + application.getScope());

		avatarUpdateJob = application.addScheduledJob(1000 / frameRate,
				new UpdateAvatarsJob(this));

		sharedObjectUpdateJob = application.addScheduledJob(1000 / 5,
				new UpdateSharedObjectJob(this));
	}

	@Override
	public boolean appStart(IScope arg0) {
		// TODO Auto-generated method stub
		System.out.println("multiplayer service starting");
		return true;
	}

	public ISharedObject getSharedObject(String name, boolean persistent) {

		ISharedObjectService service = (ISharedObjectService) ScopeUtils
				.getScopeService(application.getScope(),
						ISharedObjectService.class, false);
		return service
				.getSharedObject(application.getScope(), name, persistent);
	}

	/**
	 * Receives player input. Update the player's avatar with the new input.
	 * Send a SyncEvent back to the player so they can synchronise immediately.
	 */
	public SyncData receiveInput(String uid, TimedInput input) {

		Avatar avatar = players.get(uid).getAvatar();

		avatar.update(input);
		System.out.println("returning " + time);
		return new SyncData(time, input.time, avatar.input, avatar.state);
	}

	public SyncData addPlayer(String id) {
		Avatar avatar = players.get(id).getAvatar();
		avatars.put(id, avatar);

		return new SyncData(time, 0, avatar.input, avatar.state);
	}

	public boolean appConnect(IConnection connection, Object[] params) {
		String name = (String) params[0];

		System.out.println(name + " connecting "
				+ connection.getClient().getId());

		Player player = new Player(name, connection);

		Kinematic kinematic = new Kinematic();

		Avatar avatar = new Avatar(kinematic);

		avatar.time = time;
		avatar.setKinematic(kinematic);

		player.setAvatar(avatar);

		// addNewPlayer(player);

		players.put(connection.getClient().getId(), player);

		System.out.println("player "
				+ players.get(connection.getClient().getId()));

		return true;
	}

	public Player getPlayerByConnection(IConnection connection) {

		for (String key : players.keySet()) {

			Player player = players.get(key);

			if (player.getConnection() == connection) {

				return player;
			}
		}

		return null;
	}

	public void appDisconnect(IConnection connection) {

		Player player = getPlayerByConnection(connection);
		players.remove(player.getContext().getId());
		player.destroy();
	}

	@Override
	public int incrementTime() {

		return time++;
	}

	@Override
	public int getTime() {
		return time;
	}
}
