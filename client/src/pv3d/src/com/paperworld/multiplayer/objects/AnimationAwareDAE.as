/* --------------------------------------------------------------------------------------
 * PaperWorld3D - building better worlds
 * --------------------------------------------------------------------------------------
 * Real-Time Multi-User Application Framework for the Flash Platform.
 * --------------------------------------------------------------------------------------
 * Copyright (C) 2008 Trevor Burton [worldofpaper@googlemail.com]
 * --------------------------------------------------------------------------------------
 * 
 * This library is free software; you can redistribute it and/or modify it under the 
 * terms of the GNU Lesser General Public License as published by the Free Software 
 * Foundation; either version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT ANY 
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A 
 * PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License along with 
 * this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, 
 * Suite 330, Boston, MA 02111-1307 USA 
 * 
 * -------------------------------------------------------------------------------------- */
package com.paperworld.multiplayer.objects 
{
	import org.papervision3d.core.animation.channel.AbstractChannel3D;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.parsers.DAE;
	
	import com.actionengine.flash.core.interfaces.IAnimatable;
	import com.actionengine.flash.util.clock.Clock;
	import com.actionengine.flash.util.clock.events.ClockEvent;
	import com.paperworld.multiplayer.objects.SynchronisableObject;	

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class AnimationAwareDAE extends SynchronisableObject implements IAnimatable
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
