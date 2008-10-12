package com.paperworld.multiplayer.lod 
{
	import com.paperworld.action.Action;
	import com.paperworld.multiplayer.objects.Avatar;	

	/**
	 * @author Trevor
	 */
	public class LodConstraint extends Action
	{		
		public function testConstraint(pov : Avatar, other : Avatar) : int
		{
			return 0;
		}
	}
}
