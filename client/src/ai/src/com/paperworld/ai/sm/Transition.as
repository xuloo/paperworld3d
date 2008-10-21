/*
 * Part of the Artificial Intelligence for Games system.
 *
 * Copyright (c) Ian Millington 2003-2006. All Rights Reserved.
 *
 * This software is distributed under licence. Use of this software
 * implies agreement with all terms and conditions of the accompanying
 * software licence.
 * 
 * Actionscript port - Trevor Burton [worldofpaper@googlemail.com]
 */
package com.paperworld.ai.sm 
{
	import com.paperworld.ai.sm.BaseTransition;	

	/**
     * Transitions map between state machines.
     */
	public class Transition extends BaseTransition 
	{
		/**
		 * The transition returns a target state to transition to.
		 */
		public function getTargetState() : StateMachineState
		{
			return null;	
		}
	}
}