package com.paperworld.flash.multiplayer.data
{
	import com.paperworld.flash.util.IRegisteredClass;
	import com.paperworld.flash.util.Registration;
	import com.paperworld.flash.util.number.Vector3;
	
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	
	import org.papervision3d.core.math.Quaternion;
	
	public class State implements IExternalizable, IRegisteredClass
	{		
		public var px:Number = 10.0;
		public var py:Number = 10.0;
		public var pz:Number = 10.0;
		public var ox:Number = 10.0;
		public var oy:Number = 10.0;
		public var oz:Number = 10.0;
		public var ow:Number = 10.0;
		
		/*private var py:Number = 0.0;
		
		private var pz:Number = 0.0;
		
		private var _position:Vector3 = new Vector3();
		
		public function get position():Vector3
		{
			_position.x = px;
			_position.y = py;
			_position.z = pz;
			
			return _position;
		}
		
		public function set position(value:Vector3):void 
		{
			px = value.x;
			py = value.y;
			pz = value.z;
		}
		
		private var ow:Number = 1.0;
		
		private var ox:Number = 0.0;
		
		private var oy:Number = 0.0;
		
		private var oz:Number = 0.0;
		
		private var _orientation:Quaternion = new Quaternion();
		
		public function get orientation():Quaternion
		{
			_orientation.x = ox;
			_orientation.y = oy;
			_orientation.z = oz;
			_orientation.w = ow;
			
			return _orientation;
		}
		
		public function set orientation(value:Quaternion):void
		{
			ox = value.x;
			oy = value.y;
			oz = value.z;
			ow = value.w;
		}*/
		
		public function get aliasName():String 
		{
			return "com.paperworld.java.impl.BasicState";
		}
		
		public function State()
		{			
			Registration.registerClass(this);
		}
		
		public function clone():State
		{
			var state:State = new State();
			//state.position = Vector3(_position.clone());
			//state.orientation = _orientation.clone();
			
			return state;
		}
		
		public function destroy():void 
		{
			
		}
		
		public function compare(other:State):Boolean
		{
			return false;
		}
		
		public function equals(other:State):Boolean
		{
			return false;
		}
		
		public function notEquals(other:State):Boolean
		{
			return !equals(other);
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeFloat(px);
			output.writeFloat(py);
			output.writeFloat(pz);
			
			output.writeFloat(ow);
			output.writeFloat(ox);
			output.writeFloat(oy);
			output.writeFloat(oz);
		}
		
		/**
		 * @inheritDoc
		 */
		public function readExternal(input:IDataInput):void
		{			
			px = input.readFloat();
			py = input.readFloat();
			pz = input.readFloat();
									
			ow = input.readFloat();
			ox = input.readFloat();
			oy = input.readFloat();
			oz = input.readFloat();
		}
	}
}