package com.paperworld.rpc.objects
{
	import com.paperworld.rpc.data.AvatarInput;
	import com.paperworld.rpc.data.AvatarState;
	
	import org.papervision3d.core.math.Matrix3D;
	import org.papervision3d.core.math.Number3D;
	import org.papervision3d.core.math.Quaternion;
	import org.papervision3d.objects.DisplayObject3D;

	public class Behaviour2D implements IAvatarBehaviour
	{
		private const radians:Number = Math.PI / 180.0;
		
		public var maxAcceleration : Number = 5

		public var maxSpeed : Number = 50;

		public var minSpeed : Number = -maxSpeed;

		public function Behaviour2D()
		{
		}
		
		public function destroy():void 
		{
			maxAcceleration = 0;
			maxSpeed = 0;
			minSpeed = 0;	
		}

		public function update(input : AvatarInput, state : AvatarState, displayObject : DisplayObject3D) : void 
		{			
			if ( input.forward ) 
				state.speed = state.speed + maxAcceleration > maxSpeed ? maxSpeed : state.speed + maxAcceleration;

			if ( input.back ) 
				state.speed = state.speed - maxAcceleration < minSpeed ? minSpeed : state.speed - maxAcceleration;
		
			displayObject.moveForward( state.speed );
			
			displayObject.yaw( input.mouseX );
			
			
			
			state.transform.copy( displayObject.transform );
			state.orientation = Quaternion.createFromMatrix( state.transform );
			//state.rotation = Math.acos(state.orientation.w) * 2 * radians;
		}
	}
}