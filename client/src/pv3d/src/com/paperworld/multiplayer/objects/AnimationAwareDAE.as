package com.paperworld.multiplayer.objects 
{
	import com.paperworld.util.clock.events.ClockEvent;	
	import com.paperworld.util.clock.Clock;	
	import com.paperworld.core.interfaces.Animatable;	

	import org.papervision3d.core.animation.channel.AbstractChannel3D;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.parsers.DAE;

	import com.paperworld.multiplayer.objects.SynchronisableObject;		

	/**
	 * @author Trevor
	 */
	public class AnimationAwareDAE extends SynchronisableObject implements Animatable
	{
		public var _channels : Array;

		public var _currentFrame : int;

		public var _numFrames : int;

		public function get dae() : DAE
		{
			return DAE( object );
		}

		public function AnimationAwareDAE(object : DisplayObject3D = null)
		{
			super( object );
		}

		override public function initialise() : void
		{
			super.initialise( );
			
			// get the animation channels
			_channels = dae.getAnimationChannels( );
		
			_currentFrame = 0;
			_numFrames = 0;
		
			for each( var channel : AbstractChannel3D in _channels )
			{
				_numFrames = Math.max( _numFrames, channel.keyFrames.length );
			}	
		}

		public function play() : void
		{
			Clock.getInstance( ).addEventListener( ClockEvent.RENDER, animate );
		}

		public function pause() : void
		{
			Clock.getInstance( ).removeEventListener( ClockEvent.RENDER, animate );
		}

		public function stop() : void
		{
			pause( );
		}

		public function animate(event : ClockEvent = null) : void
		{
			if(_channels)
			{
				for each(var channel : AbstractChannel3D in _channels)
				{
					channel.updateToFrame( _currentFrame );
				}
				
				_currentFrame++;
				_currentFrame = _currentFrame < _numFrames ? _currentFrame : 0;
			}	
		}
	}
}
