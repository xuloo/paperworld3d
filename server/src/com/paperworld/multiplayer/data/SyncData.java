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
package com.paperworld.multiplayer.data;

public class SyncData {

	public int t;	

	protected int serverTime;

	public Input input;

	public State state;

	public SyncData(int serverTime, Input input, State state) {
		this.serverTime = serverTime;
		this.input = input;
		this.state = state;
	}
	
	public SyncData(int serverTime, int time, Input input, State state) {
		this.serverTime = serverTime;
		t = time;
		this.input = input;
		this.state = state;
	}

	public int getT() {
		return t;
	}

	public void setT(int t) {
		this.t = t;
	}
	
	public int getServerTime() {
		return serverTime;
	}
	
	public void setServerTime(int serverTime) {
		this.serverTime = serverTime;
	}

	public Input getInput() {
		return input;
	}

	public void setInput(Input input) {
		this.input = input;
	}

	public State getState() {
		return state;
	}

	public void setState(State state) {
		this.state = state;
	}
}
