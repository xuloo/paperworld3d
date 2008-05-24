package com.paperworld.rpc.smoothers
{
	import com.paperworld.rpc.data.AvatarState;
	
	public interface ISmoother
	{		
		function smooth(from:AvatarState, to:AvatarState, tightness:Number):void;
	}
}