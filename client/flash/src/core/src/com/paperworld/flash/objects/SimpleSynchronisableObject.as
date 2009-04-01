package com.paperworld.flash.objects 
{
	import com.paperworld.api.ISynchronisedObject;
	import com.paperworld.flash.data.State;
	import com.paperworld.flash.input.Input;
	import com.paperworld.flash.util.logging.Logger;
	import com.paperworld.flash.util.logging.LoggerContext;
	
	import flash.display.Sprite;	

	/**
	 * @author Trevor
	 */
	public class SimpleSynchronisableObject implements ISynchronisedObject 
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

		public function synchronise(time : int, input : Input, state : State) : void
		{
			this.object.x = state.position.x;
			this.object.y = state.position.y;

			object.rotation = state.orientation.w;
		}

		public function destroy() : void
		{
		}
	}
}

