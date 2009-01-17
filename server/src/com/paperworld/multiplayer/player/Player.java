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
package com.paperworld.multiplayer.player;

import org.red5.server.api.IConnection;

import com.paperworld.java.api.ISynchronisedAvatar;
import com.paperworld.multiplayer.objects.FixedUpdateRateAvatar;

public class Player {

	protected PlayerContext context;

	protected ISynchronisedAvatar avatar;

	protected String name;

	public Player() {

	}

	public Player(String name, IConnection connection) {
		this.name = name;
		context = new PlayerContext(connection);
	}

	public ISynchronisedAvatar getAvatar() {
		return avatar;
	}

	public void setAvatar(ISynchronisedAvatar avatar) {
		this.avatar = avatar;
		this.avatar.setPlayerContext(getContext());
	}

	public void Avatar(FixedUpdateRateAvatar avatar) {
		this.avatar = avatar;
	}

	public PlayerContext getContext() {
		return context;
	}
	
	public IConnection getConnection() {
		return context.getConnection();
	}
	
	public void setConnection(IConnection connection) {
		context = new PlayerContext(connection);
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public void destroy() {
		avatar.destroy();
	}
}
