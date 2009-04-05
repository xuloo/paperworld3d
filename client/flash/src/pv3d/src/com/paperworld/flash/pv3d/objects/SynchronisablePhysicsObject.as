package com.paperworld.flash.pv3d.objects 
{
	import com.paperworld.flash.multiplayer.data.State;
	import com.paperworld.flash.util.input.Input;
	import com.paperworld.flash.util.number.Vector3;
	
	import org.papervision3d.objects.DisplayObject3D;	

	/**
	 * @author Trevor
	 */
	public class SynchronisablePhysicsObject extends SynchronisableObject 
	{
		public var physicsObject : *;

		public function SynchronisablePhysicsObject(displayObject : DisplayObject3D = null, physicsObject : * = null) 
		{
			super( displayObject );
			
			this.physicsObject = physicsObject;
		}

		override public function synchronise(time : int, input : Input, state : State) : void
		{
			physicsObject.px = state.position.x;
			physicsObject.py = state.position.y;
			physicsObject.velocity = new Vector3( state.velocity.x, state.velocity.z );
			
			super.synchronise( time, input, state );
		}
	}
}
