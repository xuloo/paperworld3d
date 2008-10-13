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
	import com.paperworld.core.BaseClass;
	import com.paperworld.input.Input;
	import com.paperworld.multiplayer.behaviours.AvatarBehaviour;
	import com.paperworld.multiplayer.behaviours.SimpleAvatarBehaviour2D;
	import com.paperworld.multiplayer.data.State;	

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class SyncObject extends BaseClass
	{
		public var defaultTightness : Number = 0.1;

		public var smoothTightness : Number = 0.01;

		public var tightness : Number;

		public var behaviour : AvatarBehaviour;

		public var input : Input;

		public var previous : State;

		public var current : State;

		public function get state() : State
		{
			return current;	
		}

		public function set state(value : State) : void
		{
			previous = current;
			current = value;
		}

		public var time : int = 0;

		public var replaying : Boolean;

		public function update() : void
		{
			behaviour.update( input, state );
			
			tightness += (defaultTightness - tightness) * 0.01;
			
			time++;
		}

		public function synchronise(t : int, state : State, input : Input) : void
		{
		}

		public function snap(state : State) : void
		{
			previous = current.clone( );
			current = state.clone( );
		}

		public function smooth() : void
		{
			tightness = smoothTightness;
		}

		override public function initialise() : void
		{
			tightness = defaultTightness;	
			time = 0;
			replaying = false;
			
			input = new Input( );
			current = new State( );
			previous = new State( );
			
			behaviour = new SimpleAvatarBehaviour2D( );
		}

		override public function destroy() : void 
		{
			time = NaN;
			tightness = NaN;
			defaultTightness = NaN;
			smoothTightness = NaN;
			
			input.destroy( );
			state.destroy( );	
		}

		public function equals(other : SyncObject) : Boolean
		{				
			return  tightness == other.tightness && time == other.time && input.equals( other.input ) && state.equals( other.state );	
		}
	}
}
