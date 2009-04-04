package com.paperworld.java.ai.statemachine.condition;

import com.paperworld.java.ai.statemachine.Condition;

public class StringMatchCondition implements Condition
{
	public String	watch;
	
	public String	target;
	
	public boolean test()
	{
		return watch.equals(target);
	}
	
}
