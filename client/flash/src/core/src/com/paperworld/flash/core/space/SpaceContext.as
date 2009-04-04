package com.paperworld.flash.core.space
{
	public class SpaceContext
	{
		private var _name:String;
		
		public function get name():String
		{
			return _name;
		}
		
		private var _location:String;
		
		public function get location():String
		{
			return _location;
		}
		
		private var _default:Boolean;
		
		public function get isDefault():Boolean
		{
			return _default;
		}
		
		public function set isDefault(value:Boolean):void 
		{
			_default = value;
		}
		
		public function SpaceContext(name:String, location:String)
		{
			_name = name;
			_location = location;
		}

	}
}