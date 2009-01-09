package com.paperworld.java.scenes;

import java.util.TimerTask;

import ape.APEngine;

public class PhysicsEnabledSceneAdapter extends FixedUpdateSceneAdapter {

	protected int physicsUpdateRate;

	public PhysicsEnabledSceneAdapter() {
		APEngine.init(1.0 / 4.0);
	}

	@Override
	public void init() {
		super.init();

		timer.scheduleAtFixedRate(new UpdatePhysicsTask(), 0,
				1000 / physicsUpdateRate);
	}

	public void setPhysicsUpdateRate(int physicsUpdateRate) {
		this.physicsUpdateRate = physicsUpdateRate;
	}

	protected class UpdatePhysicsTask extends TimerTask {

		@Override
		public void run() {
			APEngine.step();
		}
	}
}
