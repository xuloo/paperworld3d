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
package com.paperworld.multiplayer.behaviour;

import com.paperworld.ai.steering.Kinematic;
import com.paperworld.multiplayer.data.Input;

public class SimpleAvatarBehaviour2D implements IAvatarBehaviour {

	public SimpleAvatarBehaviour2D() {

	}

	public void update(int time, Input input, Kinematic kinematic) {

		if (input != null) {
			if (input.getForward())
				kinematic.position.z += 5;

			if (input.getBack())
				kinematic.position.z -= 5;

			if (input.getMoveRight())
				kinematic.position.x += 5;

			if (input.getMoveLeft())
				kinematic.position.x -= 5;

			if (input.getTurnRight())
				kinematic.orientation.w += 1;

			if (input.getTurnLeft())
				kinematic.orientation.w -= 1;
		}
		
		//System.out.println("rotation: " + kinematic.orientation.w);
	}

}
