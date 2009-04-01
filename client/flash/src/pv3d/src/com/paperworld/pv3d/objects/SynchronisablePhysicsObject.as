package com.paperworld.pv3d.objects 
{
	import com.actionengine.flash.api.IInput;
	import com.brainfarm.flash.data.State;
	import com.paperworld.pv3d.objects.SynchronisableObject;
	
	import org.cove.ape.AbstractParticle;
	import org.cove.ape.Vector;
	import org.papervision3d.objects.DisplayObject3D;	

	/**
	 * @author Trevor
	 */
	public class SynchronisablePhysicsObject extends SynchronisableObject 
	{
		public var physicsObject : AbstractParticle;

		public function SynchronisablePhysicsObject(displayObject : DisplayObject3D = null, physicsObject : AbstractParticle = null) 
		{
			super( displayObject );
			
			this.physicsObject = physicsObject;
		}

		override public function synchronise(time : int, input : IInput, state : State) : void
		{
			physicsObject.px = state.position.x;
			physicsObject.py = state.position.y;
			physicsObject.velocity = new Vector( state.velocity.x, state.velocity.z );
			
			super.synchronise( time, input, state );
		}
	}
}
