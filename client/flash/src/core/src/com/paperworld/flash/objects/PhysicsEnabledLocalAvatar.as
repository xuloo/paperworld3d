package com.paperworld.flash.objects 
{
	import com.actionengine.flash.api.IInput;
	import com.brainfarm.flash.data.State;
	import com.paperworld.flash.objects.LocalAvatar;	

	/**
	 * @author Trevor
	 */
	public class PhysicsEnabledLocalAvatar extends LocalAvatar 
	{
		/**
		 * The amount that this object's time will change by on the next update() call.
		 */
		public var deltaTime : Number = 1;

		public var lastTime : int = 0;

		public function PhysicsEnabledLocalAvatar()
		{
			super( );
		}

		override public function update() : void
		{								
			_time += deltaTime;
				
			var integerTime : int = int( _time ) - lastTime;
			
			while (integerTime > 0)
			{				
				integerTime -= 1;
			}
			
			lastTime = int( _time );
			
			// update scene
			super.update( );		
		}

		override public function synchronise(time : int, input : IInput, state : State) : void
		{            	
			// Handle the server time update.
			if (time > _time)
			{
				deltaTime = 1.25;
			}
			else if (time < _time)
			{
				deltaTime = 0.75;
			}
			else
			{
				deltaTime = 1.0;
			}
		}
	}
}
