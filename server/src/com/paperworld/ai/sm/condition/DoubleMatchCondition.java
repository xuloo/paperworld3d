package com.paperworld.ai.sm.condition;

import com.paperworld.ai.sm.Condition;

public class DoubleMatchCondition implements Condition
{
	public double watch;
	
	public double target;
	
	public boolean test()
	{
		return watch == target;
	}
	
}
