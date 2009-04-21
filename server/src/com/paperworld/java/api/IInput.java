package com.paperworld.java.api;

import org.red5.io.amf3.IExternalizable;

public interface IInput extends IExternalizable {

	public boolean getForward();
	
	public void setForward(boolean forward);

	public boolean getBackward();
	
	public void setBackward(boolean backward);

	public boolean getRight();
	
	public void setRight(boolean right);

	public boolean getLeft();
	
	public void setLeft(boolean left);

	public boolean getUp();
	
	public void setUp(boolean up);

	public boolean getDown();
	
	public void setDown(boolean down);

	public boolean getPitchPositive();
	
	public void setPitchPositive(boolean pitchPositive);
	
	public boolean getPitchNegative();
	
	public void setPitchNegative(boolean pitchNegative);

	public boolean getRollPositive();
	
	public void setRollPositive(boolean rollPositive);

	public boolean getRollNegative();
	
	public void setRollNegative(boolean rollNegative);
	
	public boolean getYawPositive();
	
	public void setYawPositive(boolean yawPositive);
	
	public boolean getYawNegative();
	
	public void setYawNegative(boolean yawNegative);

	public boolean getFire();
	
	public void setFire(boolean fire);
	
	public boolean getJump();
	
	public void setJump(boolean jump);
}