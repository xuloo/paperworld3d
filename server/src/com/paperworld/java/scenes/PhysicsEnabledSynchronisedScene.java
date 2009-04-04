package com.paperworld.java.scenes;

import java.util.TimerTask;

public class PhysicsEnabledSynchronisedScene extends FixedUpdateSynchronisedScene {

	protected int physicsUpdateRate;
	
	protected double numerator = 1.0;
	
	protected double denominator = 4.0;

	public PhysicsEnabledSynchronisedScene() {
		
	}

	@Override
	public void init() {
		//APEngine.init(numerator / denominator);
		
		super.init();

		timer.scheduleAtFixedRate(new UpdatePhysicsTask(), 0,
				1000 / physicsUpdateRate);
	}

	public void setPhysicsUpdateRate(int physicsUpdateRate) {
		this.physicsUpdateRate = physicsUpdateRate;
	}
	
	public void setNumerator(double numerator) {
		this.numerator = numerator;
	}
	
	public void setDenominator(double denominator) {
		this.denominator = denominator;
	}

	protected class UpdatePhysicsTask extends TimerTask {

		@Override
		public void run() {
			
		}
	}
}
