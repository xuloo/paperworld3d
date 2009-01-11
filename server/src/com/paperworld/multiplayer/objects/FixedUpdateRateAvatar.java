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
package com.paperworld.multiplayer.objects;

import com.actionengine.java.data.Input;
import com.actionengine.java.util.collections.CircularBuffer;
import com.brainfarm.java.steering.Kinematic;
import com.paperworld.multiplayer.data.TimedInput;

public class FixedUpdateRateAvatar extends SynchronisedAvatar {

	public CircularBuffer<TimedInput> buffer;

	public FixedUpdateRateAvatar() {
		super();
	}

	public FixedUpdateRateAvatar(Kinematic kinematic) {
		super(kinematic);

		initialise();
	}

	@Override
	public void initialise() {
		buffer = new CircularBuffer<TimedInput>(TimedInput.class);

		super.initialise();
	}	
	
	@Override 
	public void setUserInput(int time, Input input) {
		this.input = input;
	}

	/*@Override
	public void updateInput(TimedInput move) {
		buffer.add(move);
		this.input = move.input;
	}*/

}
