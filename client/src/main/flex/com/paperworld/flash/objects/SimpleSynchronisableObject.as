package com.paperworld.flash.objects 
{
	import flash.display.Sprite;
	
	import com.actionengine.flash.core.BaseClass;
	import com.actionengine.flash.input.Input;
	import com.actionengine.flash.util.logging.Logger;
	import com.actionengine.flash.util.logging.LoggerContext;
	import com.paperworld.flash.data.State;
	import com.paperworld.util.Synchronizable;		

	/**
	 * @author Trevor
	 */
	public class SimpleSynchronisableObject extends BaseClass implements Synchronizable 
	{
		private var logger : Logger = LoggerContext.getLogger( SimpleSynchronisableObject );

		public var object : Sprite;

		public function SimpleSynchronisableObject(object : Sprite = null)
		{
			super( );
			
			this.object = object;
		}

		public function getObject() : *
		{
			return object;
		}

		public function synchronise(input : Input, state : State) : void
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

import com.paperworld.flash.data.State;