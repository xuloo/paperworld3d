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
package com.paperworld.core.avatar;

/**
 * AvatarInput holds the state of a user's input.
 * 
 * @author Trevor
 * 
 */
public class AvatarInput {
	public Boolean left = false;

	public Boolean right = false;

	public Boolean forward = false;

	public Boolean back = false;

	public Boolean up = false;

	public Boolean down = false;

	public Boolean yawNegative = false;

	public Boolean yawPositive = false;

	public Boolean pitchNegative = false;

	public Boolean pitchPositive = false;

	public Boolean rollNegative = false;

	public Boolean rollPositive = false;

	public Double mouseX = 0.0;

	public Double mouseY = 0.0;

	public Boolean firing = false;

	public Boolean hasChanged = false;

	/**
	 * Constructor.
	 */
	public AvatarInput() {

	}

	public void update(AvatarInput input) {
		if (left != input.left || right != input.right
				|| forward != input.forward || back != input.back
				|| yawNegative != input.yawNegative
				|| yawPositive != input.yawPositive
				|| pitchPositive != input.pitchPositive
				|| pitchNegative != input.pitchNegative
				|| firing != input.firing) {
			hasChanged = true;
		}

		left = input.left;
		right = input.right;
		forward = input.forward;
		back = input.back;
		yawNegative = input.yawNegative;
		yawPositive = input.yawPositive;
		pitchPositive = input.pitchPositive;
		pitchNegative = input.pitchNegative;
		firing = input.firing;
	}

	public Boolean equals(AvatarInput other) {
		return mouseX == other.mouseX && mouseY == other.mouseY;
	}

	public String toString() {
		return "yawNeg: " + yawNegative + " YawPos: " + yawPositive
				+ " pitchNeg: " + pitchNegative + " pitchPos: " + pitchPositive
				+ " rollNeg: " + rollNegative + " rollPos: " + rollPositive
				+ " up: " + up + " down: " + down + " forward: " + forward
				+ " back: " + back + " left: " + left + " right: " + right
				+ " mouseX: " + mouseX + " mouseY: " + mouseY;
	}

}
