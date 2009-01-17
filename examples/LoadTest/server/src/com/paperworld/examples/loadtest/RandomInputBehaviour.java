package com.paperworld.examples.loadtest;

import java.util.Random;

import com.actionengine.api.IInput;
import com.paperworld.java.api.IBehaviour;
import com.paperworld.java.api.ISynchronisedAvatar;

public class RandomInputBehaviour implements IBehaviour{

	protected Random generator = new Random();
	
	protected int total = 100;
	
	protected int chance = 5;
	
	@Override
	public void apply(ISynchronisedAvatar avatar) {
		
		IInput input = avatar.getInput();
		
		if (generator.nextInt(total) > chance) {
			input.setMoveUp(true);
		}
	}

}
