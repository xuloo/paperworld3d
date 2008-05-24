package com.paperworld.rpc.smoothers
{
	import com.paperworld.rpc.data.AvatarState;
	import com.paperworld.rpc.objects.RemoteObject;
	
	public class AbstractSmoother implements ISmoother
	{
		protected var _target:RemoteObject;
		
		public function set target(value:RemoteObject):void
		{
			_target = value;
		}
		
		public function AbstractSmoother()
		{
		}

		public function smooth(from:AvatarState, to:AvatarState, tightness:Number):void
		{
		}
		
	}
}