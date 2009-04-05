package com.paperworld.flash.multiplayer.data
{
	import com.paperworld.flash.util.number.Vector3;
	
	import org.papervision3d.core.math.Matrix3D;
	import org.papervision3d.core.math.Quaternion;
	
	public class State
	{
		public var transform:Matrix3D;
		
		public var position:Vector3;
		
		public var orientation:Quaternion;
		
		public var velocity:Vector3;
		
		public var rotation:Number;
		
		public var forces:Vector3;
		
		public function State()
		{
		}
		
		public function clone():State
		{
			return null;
		}
		
		public function destroy():void 
		{
			
		}
		
		public function compare(other:State):Boolean
		{
			return false;
		}
		
		public function getTransform():Matrix3D
		{
			return transform;
		}
		
		public function setTransform(transform:Matrix3D):void 
		{
			this.transform = transform;
		}
		
		public function getPosition():Vector3
		{
			return position;
		}
		
		public function setPosition(position:Vector3):void 
		{
			this.position = position;
		}
		
		public function getOrientation():Quaternion
		{
			return orientation;
		}
		
		public function setOrientation(orientation:Quaternion):void
		{
			this.orientation = orientation;
		}
		
		public function getVelocity():Vector3
		{
			return velocity;
		}
		
		public function setVelocity(velocity:Vector3):void
		{
			this.velocity = velocity;
		}
		
		public function getRotation():Number 
		{
			return rotation;
		}
		
		public function setRotation(rotation:Number):void 
		{
			this.rotation = rotation;
		}
		
		public function getForces():Vector3
		{
			return forces;
		}
		
		public function setForces(forces:Vector3):void 
		{
			this.forces = forces;
		}
		
		public function equals(other:State):Boolean
		{
			return false;
		}
		
		public function notEquals(other:State):Boolean
		{
			return !equals(other);
		}
	}
}