package com.paperworld.flash.pv3d.objects 
{
	import com.paperworld.flash.api.multiplayer.ISynchronisedObject;
	import com.paperworld.flash.multiplayer.data.State;
	import com.paperworld.flash.util.input.IInput;
	
	import org.papervision3d.objects.DisplayObject3D;	

	/**
	 * @author Trevor
	 */
	public class SynchronisablePhysicsObject implements ISynchronisedObject
	{
		private var _displayObject : *;
		
		public function get displayObject() : *
		{
			return _displayObject;
		}

		public function set displayObject(value : *) : void
		{
			_displayObject = value;
		}

		public function SynchronisablePhysicsObject(displayObject : DisplayObject3D = null, physicsObject : * = null) 
		{			
			this.displayObject = displayObject;
		}

		public function synchronise(time : int, input : IInput, state : State) : void
		{
			//physicsObject.px = state.position.x;
			//physicsObject.py = state.position.y;
			//physicsObject.velocity = new Vector3( state.velocity.x, state.velocity.z );
			
			super.synchronise( time, input, state );
		}
	}
}
