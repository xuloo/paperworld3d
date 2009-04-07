package com.paperworld.flash.core.space
{
	import com.paperworld.flash.core.objects.IPaperworldObject;
	import com.paperworld.flash.core.space.files.FileDefinition;
	import com.paperworld.flash.core.space.interfaces.ISpaceView;
	import com.paperworld.flash.util.patterns.iterator.IIterator;
	
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
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
		
		private var _files:Dictionary;
		
		public function get files():IIterator 
		{
			return new FilesIterator(_files);
		}
		
		private var _views:Dictionary;
		
		public function get views():Dictionary
		{
			return _views;
		}
		
		public function addView(value:ISpaceView):void 
		{
			if (!_views)
			{
				_views = new Dictionary();
			}
			
			_views[value.name] = value;
		}
		
		private var _actors:Array;
		
		public function get actors():Array 
		{
			return _actors;
		}
		
		public function addActor(actor:IPaperworldObject):void 
		{
			if (!_actors)
			{
				_actors = new Array();
			}
			
			_actors.push(actor);
		}
		
		private var _target:Sprite;
		
		public function get target():Sprite 
		{
			return _target;
		}
		
		public function set target(value:Sprite):void 
		{
			_target = value;
		}
		
		public function SpaceContext(name:String, location:String)
		{
			_name = name;
			_location = location;
			
			_files = new Dictionary(true);
		}

		public function registerFileDefinition(file:FileDefinition):void 
		{
			if (_files[file.type] == null)
			{
				_files[file.type] = new Array();
			}
			
			(_files[file.type] as Array).push(file);
		}
	}
}

import com.paperworld.flash.util.patterns.iterator.IIterator;
import flash.utils.Dictionary;
	
internal class FilesIterator implements IIterator
{
	private var _collection:Array;
	
	private var _index:int;
	
	public function FilesIterator(files:Dictionary)
	{
		_collection = new Array();
		
		for each (var array:Array in files)
		{
			_collection = _collection.concat(array);
		}
	}
	
	public function reset():void 
	{
		_index = 0;
	}
	
	public function hasNext():Boolean
	{
		return _index < _collection.length;
	}
	
	public function next():* 
	{
		return _collection[_index++];
	}
	
	public function size():int 
	{
		return _collection.length;
	}
}