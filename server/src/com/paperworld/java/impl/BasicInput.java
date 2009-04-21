package com.paperworld.java.impl;

import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IDataOutput;

import com.paperworld.java.api.IInput;

public class BasicInput implements IInput {

	protected boolean forward;

	@Override
	public boolean getForward() {
		return forward;
	}
	
	@Override
	public void setForward(boolean forward) {
		this.forward = forward;
	}
	
	protected boolean backward;
	
	@Override
	public boolean getBackward() {
		return backward;
	}
	
	@Override
	public void setBackward(boolean backward) {
		this.backward = backward;
	}
	
	protected boolean left;

	@Override
	public boolean getLeft() {
		return left;
	}
	
	@Override
	public void setLeft(boolean left) {
		this.left = left;
	}
	
	protected boolean right;

	@Override
	public boolean getRight() {
		return right;
	}
	
	@Override
	public void setRight(boolean right) {
		this.right = right;
	}
	
	protected boolean up;

	@Override
	public boolean getUp() {
		return up;
	}
	
	@Override
	public void setUp(boolean up) {
		this.up = up;
	}
	
	protected boolean down;

	@Override
	public boolean getDown() {
		return down;
	}
	
	@Override
	public void setDown(boolean down) {
		this.down = down;
	}
	
	protected boolean pitchPositive;

	@Override
	public boolean getPitchPositive() {
		return pitchPositive;
	}
	
	@Override
	public void setPitchPositive(boolean pitchPositive) {
		this.pitchPositive = pitchPositive;
	}	
	
	protected boolean pitchNegative;

	@Override
	public boolean getPitchNegative() {
		return pitchNegative;
	}
	
	@Override
	public void setPitchNegative(boolean pitchNegative) {
		this.pitchNegative = pitchNegative;
	}
	
	protected boolean rollPositive;

	@Override
	public boolean getRollPositive() {
		return rollPositive;
	}
	
	@Override
	public void setRollPositive(boolean rollPositive) {
		this.rollPositive = rollPositive;
	}

	protected boolean rollNegative;
	
	@Override
	public boolean getRollNegative() {
		return rollNegative;
	}
	
	@Override
	public void setRollNegative(boolean rollNegative) {
		this.rollNegative = rollNegative;
	}

	protected boolean yawPositive;

	@Override
	public boolean getYawPositive() {
		return yawPositive;
	}

	@Override
	public void setYawPositive(boolean yawPositive) {
		this.yawPositive = yawPositive;
	}
	
	protected boolean yawNegative;
	
	@Override
	public boolean getYawNegative() {
		return yawNegative;
	}
	
	@Override
	public void setYawNegative(boolean yawNegative) {
		this.yawNegative = yawNegative;
	}

	protected boolean fire;

	@Override
	public boolean getFire() {
		return fire;
	}

	@Override
	public void setFire(boolean fire) {
		this.fire = fire;
	}

	protected boolean jump;

	@Override
	public boolean getJump() {
		return jump;
	}

	@Override
	public void setJump(boolean jump) {
		this.jump = jump;
	}

	@Override
	public void readExternal(IDataInput input) {
		forward = input.readBoolean();
		backward = input.readBoolean();
		right = input.readBoolean();
		left = input.readBoolean();
		up = input.readBoolean();
		down = input.readBoolean();
		pitchPositive = input.readBoolean();
		pitchNegative = input.readBoolean();		
		rollPositive = input.readBoolean();
		rollNegative = input.readBoolean();		
		yawPositive = input.readBoolean();
		yawNegative = input.readBoolean();		
		fire = input.readBoolean();
		jump = input.readBoolean();
	}

	@Override
	public void writeExternal(IDataOutput output) {
		output.writeBoolean(forward);
		output.writeBoolean(backward);
		output.writeBoolean(right);
		output.writeBoolean(left);
		output.writeBoolean(up);
		output.writeBoolean(down);
		output.writeBoolean(pitchPositive);
		output.writeBoolean(pitchNegative);
		output.writeBoolean(rollPositive);
		output.writeBoolean(rollNegative);
		output.writeBoolean(yawPositive);
		output.writeBoolean(yawNegative);
		output.writeBoolean(fire);
		output.writeBoolean(jump);
	}

}
