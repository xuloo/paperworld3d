package com.paperworld.rpc.objects
{
	import com.paperworld.rpc.data.AvatarState;
	import com.paperworld.rpc.data.AvatarInput;
	import org.papervision3d.objects.DisplayObject3D;

	public class BehaviourTest implements IAvatarBehaviour
	{
		public function BehaviourTest()
		{
		}

		public function update(input:AvatarInput, state:AvatarState, displayObject:DisplayObject3D):void
		{
		}
		
		public function destroy():void
		{
		}
		
	}
}