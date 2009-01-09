package com.paperworld.java.scenes;

import java.util.TimerTask;

import ape.APEngine;

public class PhysicsEnabledSceneAdapter extends SynchronisedSceneAdapter {

	private static APEngine engine;

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

	protected class UpdatePhysicsTask extends TimerTask {

		@Override
		public void run() {
			APEngine.step();
		}

	}
}
