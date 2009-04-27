package com.paperworld.flash.multiplayer.objects 
{
	import com.paperworld.flash.api.multiplayer.ISynchronisedObject;
	import com.paperworld.flash.multiplayer.data.State;
	import com.paperworld.flash.util.input.IInput;
	
	import flash.display.Sprite;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;	

	/**
	 * @author Trevor
	 */
	public class SimpleSynchronisableObject implements ISynchronisedObject 
	{
		private static var logger:ILogger = LoggerFactory.getLogger("Paperworld");

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
			this.object.x = state.px;
			//this.object.y = state.py;

			//object.rotation = state.ow;
		}

		public function destroy() : void
		{
		}
	}
}

