package com.paperworld.flash.core.space.files
{
	import com.paperworld.flash.core.action.Action;
	import com.paperworld.flash.core.loading.actions.AbstractLoadAction;
	
	import flash.events.Event;
	import flash.system.ApplicationDomain;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;
	import org.as3commons.reflect.ClassUtils;
	
	public class FileDefinition extends Action
	{
		private static var logger:ILogger = LoggerFactory.getLogger("Paperworld(Core)");
		
		private var _type:FileType;
		
		public function get type():FileType 
		{
			return _type;
		}
				
		private var _location:String;
		
		public function get location():String 
		{
			return _location;
		}
		
		private var _name:String;
		
		public function get name():String 
		{
			return _name;
		}
		
		private var _depends:Array;
		
		private var _loadAction:Action;
		
		private var _queue:Action;
		
		private var _loading:Boolean;
		
		public function set queue(value:Action):void 
		{
			_queue = value;
		}
		
		public function FileDefinition(name:String, type:String, location:String, depends:Array)
		{
			_name = name;
			_type = FileType.fromName(type);
			_location = location;
			_depends = depends;
			
			_loadAction = getLoadAction(this);
			_loadAction.addEventListener(Event.COMPLETE, _onLoadComplete);
		}
		
		override public function act():void 
		{
			logger.info(AbstractLoadAction(_loadAction).urlRequest.url + " : " + _loading + " " + canAct);
			if (!_loading && canAct)
			{
				_loading = true;
				_loadAction.act();
			}
		}
		
		override public function get canAct():Boolean 
		{
			var next:Action = _queue;
			
			while (next) 
			{
				if (next != this)
				{
					if (!canDoBoth(next))
					{
						return false;
					}
				}
				
				next = next.next;
			}
			
			return true;
		}
		
		override public function canDoBoth(other:Action):Boolean
		{
			for each (var name:String in _depends)
			{
				if (FileDefinition(other).name == name)
				{
					if (!other.isComplete)
					{
						return false;
					}
				}
			}
			
			return true;
		}
		
		override public function get isComplete():Boolean 
		{
			return _loadAction.isComplete;
		}
		
		private function _onLoadComplete(event:Event):void 
		{
			dispatchEvent(new Event(Event.COMPLETE));
		}

		public static function getLoadAction(file:FileDefinition):Action
		{
			var clazz:Class = ClassUtils.forName(getLoaderClassName(file.type.name), ApplicationDomain.currentDomain);
			
			return new clazz(file);
		}
		
		private static function getLoaderClassName(type:String):String
		{
			return "com.paperworld.flash.core.loading.actions." + type + "LoadAction";
		}
	}
}