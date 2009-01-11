package com.paperworld.examples.loadtest;

import java.util.Random;

import com.actionengine.java.data.Input;
import com.paperworld.java.api.IAvatar;
import com.paperworld.java.api.IBehaviour;

public class RandomInputBehaviour implements IBehaviour{

	protected Random generator = new Random();
	
	protected int total = 100;
	
	protected int chance = 5;
	
	@Override
	public void apply(IAvatar avatar) {
		
		Input input = avatar.getInput();
		
		if (generator.nextInt(total) > chance) {
			input.setMoveUp(true);
		}
	}

}
