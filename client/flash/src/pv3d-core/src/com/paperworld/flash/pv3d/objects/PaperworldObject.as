package com.paperworld.flash.pv3d.objects
{
	import com.paperworld.flash.core.action.Action;
	import com.paperworld.flash.core.objects.IPaperworldObject;
	import com.paperworld.flash.pv3d.behaviours.BasePV3DBehaviour;
	
	import org.papervision3d.objects.DisplayObject3D;

	public class PaperworldObject implements IPaperworldObject
	{
		private var _behaviour:Action;
		
		public function get behaviour():Action
		{
			return _behaviour;
		}
		
		public function set behaviour(value:Action):void
		{
			_behaviour = value;
			BasePV3DBehaviour(_behaviour).actor = this;
		}
		
		private var _displayObject:DisplayObject3D;
		
		public function get displayObject():*
		{
			return _displayObject;
		}
		
		public function set displayObject(value:*):void 
		{
			_displayObject = value;
		}
		
		public function PaperworldObject()
		{
		}

		
		
	}
}