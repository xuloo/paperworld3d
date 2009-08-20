package com.paperworld.java.ai.statemachine.condition;

import com.paperworld.java.ai.statemachine.Condition;

public class DoubleMatchCondition implements Condition
{
	public double watch;
	
	public double target;
	
	public boolean test()
	{
		return watch == target;
	}
	
}
