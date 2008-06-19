package com.paperworld.rpc.objects
{
	import com.paperworld.rpc.data.AvatarInput;
	import com.paperworld.rpc.data.AvatarState;
	
	import org.papervision3d.core.math.Quaternion;
	import org.papervision3d.objects.DisplayObject3D;
	
	public class SimpleBehaviour2D implements IAvatarBehaviour
	{
		private var speed:int = 5;
		
		public function SimpleBehaviour2D()
		{
		}
		
		public function destroy():void 
		{
			
		}
		
		public function update(input : AvatarInput, state : AvatarState, displayObject : DisplayObject3D) : void 
		{			
			displayObject.copyTransform(state.transform);
			
			if ( input.forward ) 
				displayObject.moveForward( speed );

			if ( input.back ) 
				displayObject.moveForward( -speed );			
			
			displayObject.yaw( input.mouseX );			
			
			state.transform.copy( displayObject.transform );
			state.orientation = Quaternion.createFromMatrix( state.transform );
		}
	}
}