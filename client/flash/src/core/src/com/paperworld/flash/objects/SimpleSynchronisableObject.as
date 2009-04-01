package com.paperworld.flash.objects 
{
	import com.actionengine.flash.api.IInput;
	import com.actionengine.flash.core.BaseClass;
	import com.actionengine.flash.util.logging.Logger;
	import com.actionengine.flash.util.logging.LoggerContext;
	import com.brainfarm.flash.data.State;
	import com.paperworld.api.ISynchronisedObject;
	
	import flash.display.Sprite;	

	/**
	 * @author Trevor
	 */
	public class SimpleSynchronisableObject extends BaseClass implements ISynchronisedObject 
	{
		private var logger : Logger = LoggerContext.getLogger( SimpleSynchronisableObject );

		public var object : Sprite;

		public function SimpleSynchronisableObject(object : Sprite = null)
		{
			super( );
			
			this.object = object;
		}

		public function get displayObject() : *
		{
			return object;
		}

		public function set displayObject(object : *) : void
		{
			this.object = object;
		}

		public function synchronise(time : int, input : IInput, state : State) : void
		{
			this.object.x = state.position.x;
			this.object.y = state.position.y;

			object.rotation = state.orientation.w;
		}

		override public function destroy() : void
		{
		}
	}
}

