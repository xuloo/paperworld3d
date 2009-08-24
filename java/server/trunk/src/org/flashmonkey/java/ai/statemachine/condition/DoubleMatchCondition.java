package org.paperworld.java.ai.statemachine.condition;

import org.paperworld.java.ai.statemachine.Condition;

public class DoubleMatchCondition implements Condition
{
	public double watch;
	
	public double target;
	
	public boolean test()
	{
		return watch == target;
	}
	
}
