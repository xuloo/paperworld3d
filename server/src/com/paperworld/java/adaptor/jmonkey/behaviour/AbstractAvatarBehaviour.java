package com.paperworld.java.adaptor.jmonkey.behaviour;

import com.paperworld.java.api.IBehaviour;
import com.paperworld.java.api.IInput;
import com.paperworld.java.api.IState;
import com.paperworld.java.impl.BasicState;

public class AbstractAvatarBehaviour implements IBehaviour {

	/** A speed value that, if desired, can change how actions are performed. */
    protected float speed = 0;
    
    public AbstractAvatarBehaviour() {
    	
    }
    
    public AbstractAvatarBehaviour(float speed) {
    	this.speed = speed;
    }

    /**
     *
     * <code>setSpeed</code> defines the speed at which this action occurs.
     *
     * @param speed
     *            the speed at which this action occurs.
     */
    public void setSpeed(float speed) {
        this.speed = speed;
    }

    /**
     * Returns the currently set speed. Speed is 0 by default.
     *
     * @return The current speed.
     */
    public float getSpeed() {
        return speed;
    }
    
	@Override
	public void update(int time, IInput input, BasicState state) {
		
	}

}
