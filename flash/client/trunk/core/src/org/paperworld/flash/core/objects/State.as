package org.paperworld.flash.core.objects
{
	import org.paperworld.flash.api.IState;
	import org.paperworld.flash.utils.IRegisteredClass;
	import org.paperworld.flash.utils.Registration;
	import org.paperworld.flash.utils.math.Quaternion;
	import org.paperworld.flash.utils.math.Vector3f;
	
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	
	public class State implements IState, IExternalizable, IRegisteredClass
	{	
		private var _position:Vector3f = new Vector3f();
		
		public function get position():Vector3f
		{			
			return _position;
		}
		
		public function set position(value:Vector3f):void 
		{
			_position = value;
		}
		
		private var _orientation:Quaternion = new Quaternion();
		
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
			Registration.registerClass(this);
		}
		
		public function clone():IState
		{
			var state:State = new State();
			state.position = _position.clone();
			state.orientation = _orientation.clone();
			
			return state;
		}
		
		public function destroy():void 
		{
			
		}
		
		public function compare(other:IState):Boolean
		{
			return false;
		}
		
		public function equals(other:IState):Boolean
		{
			return false;
		}
		
		public function notEquals(other:IState):Boolean
		{
			return !equals(other);
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeObject(_position);
			output.writeObject(_orientation);
		}
		
		/**
		 * @inheritDoc
		 */
		public function readExternal(input:IDataInput):void
		{			
			_position = input.readObject();
			_orientation = input.readObject();
		}
	}
}