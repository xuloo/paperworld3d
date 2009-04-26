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
		public var _position:Vector3;
		
		public function get position():Vector3
		{
			return _position;
		}
		
		public function set position(value:Vector3):void 
		{
			_position = position;
		}
		
		private var _orientation:Quaternion;
		
		public function get orientation():Quaternion
		{
			return _orientation;
		}
		
		public function set orientation(value:Quaternion):void
		{
			_orientation = value;
		}
		
		public function get aliasName():String 
		{
			return "com.paperworld.java.impl.BasicState";
		}
		
		public function State()
		{
			_position = new Vector3();
			_orientation = new Quaternion();
			
			Registration.registerClass(this);
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
			output.writeFloat(_position.x);
			output.writeFloat(_position.y);
			output.writeFloat(_position.z);
			output.writeFloat(_orientation.w);
			output.writeFloat(_orientation.x);
			output.writeFloat(_orientation.y);
			output.writeFloat(_orientation.z);
		}
		
		/**
		 * @inheritDoc
		 */
		public function readExternal(input:IDataInput):void
		{
			_position.x = input.readFloat();
			_position.y = input.readFloat();
			_position.z = input.readFloat();
			_orientation.w = input.readFloat();
			_orientation.x = input.readFloat();
			_orientation.y = input.readFloat();
			_orientation.z = input.readFloat();
		}
	}
}