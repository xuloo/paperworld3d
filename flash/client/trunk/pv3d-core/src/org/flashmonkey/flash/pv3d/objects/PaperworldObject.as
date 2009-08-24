package org.paperworld.flash.pv3d.objects
{
	import org.paperworld.flash.api.IInput;
	import org.paperworld.flash.api.IPaperworldObject;
	import org.paperworld.flash.api.IState;
	import org.paperworld.flash.core.action.Action;
	import org.paperworld.flash.pv3d.behaviours.BasePV3DBehaviour;
	
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

		public function synchronise(time : int, input : IInput, state : IState) : void
		{
			
		}
		
	}
}