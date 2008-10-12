package com.paperworld.ai.sm.condition;

import com.paperworld.ai.sm.Condition;

public class StringMatchCondition implements Condition
{
	public String	watch;
	
	public String	target;
	
	public boolean test()
	{
		return watch.equals(target);
	}
	
}
