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
package com.paperworld.flash.ai.sm 
{

	/**
	 * The condition interface offsets the problem of whether
	 * transitions should fire by having a separate set of condition
	 * instances that can be combined together with boolean operators.
	 */
	public class Condition 
	{
		/**
		 * Performs the test for this condition.
		 */
		public function test() : Boolean
		{	
			return false;
		}
	}
}