package org.paperworld.flash.core.avatar
{
	import org.paperworld.flash.api.IAvatar;
	import org.paperworld.flash.api.IBehaviour;
	import org.paperworld.flash.api.IInput;
	import org.paperworld.flash.api.IPaperworldObject;
	import org.paperworld.flash.api.IState;
	import org.paperworld.flash.api.IUpdatable;
	import org.paperworld.flash.core.objects.State;
	import org.paperworld.flash.utils.input.Input;
	
	import flash.events.Event;

	public class AbstractAvatar implements IAvatar, IUpdatable
	{
		private var _id:String;
		
		public function get id():String
		{
			return _id;
		}
		
		public function set id(value:String):void
		{
			_id = value;
		}
		
		private var _object:IPaperworldObject;
		
		public function get object():IPaperworldObject
		{
			return _object;
		}
		
		public function set object(value:IPaperworldObject):void
		{
			_object = value;
		}
		
		private var _time:int;
		
		public function get time():int
		{
			return _time;
		}
		
		public function set time(value:int):void
		{
			_time = value;
		}
		
		private var _input:IInput = new Input();
		
		public function get input():IInput
		{
			return _input;
		}
		
		public function set input(value:IInput):void
		{
			_input = value;
		}
		
		private var _state:IState = new State();
		
		public function get state():IState
		{
			return _state;
		}
		
		public function set state(value:IState):void
		{
			_state = value;
		}
		
		protected var _behaviour:IBehaviour;
		
		public function set behaviour(value:IBehaviour):void
		{
			_behaviour = value;
		}
		
		public function AbstractAvatar()
		{
		}	
		
		public function update(e:Event = null):void 
		{	
			// Updates the state from the current input.
			_behaviour.apply(this);
			
			// Synchronise the object to the current state.
			_object.synchronise(_time, _input, _state);
		}
	}
}