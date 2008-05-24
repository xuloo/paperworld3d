/*
 * --------------------------------------------------------------------------------------
 * PaperWorld3D - building better worlds
 * --------------------------------------------------------------------------------------
 * Realtime 3D Multi-User Application Framework for the Flash Platform.
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
 * --------------------------------------------------------------------------------------
 */
package com.paperworld.rpc.input
{
	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.rpc.timer.GameTimer;
	import com.paperworld.rpc.timer.events.IntegrationEvent;
	
	import flash.events.EventDispatcher;	

	/**
	 * <p>Implements the <code>IUserInput</code> interface.</p>
	 * 
	 * <p>Initialises two instances of <code>InputData</code> - one for the current timestep and
	 * one for the previous timestep, this is required so that the user's current input can 
	 * be compared with what they did last timestep, if there's a change in behaviour then the input
	 * is sent to the server. If they're the same then there's no reason to take up bandwidth.</p>
	 * 
	 * @see com.paperworld.rpc.input.IUserInput
	 * @see com.paperworld.rpc.input.InputData
	 */
	public class AbstractUserInput extends EventDispatcher implements IUserInput
	{
		/**
		 * The state of the user's input in the current timestep.
		 */
		public var current : InputData;

		/**
		 * The state of the user's input in the previous timestep.
		 */
		public var previous : InputData;

		/**
		 * Flags whether or not this user's input has changed since the last tick.
		 */
		protected var $hasChanged : Boolean;

		/**
		 * The value of the current timestep.
		 */
		public var time : int;

		public var logger : XrayLog = new XrayLog( );

		/**
		 * Returns whether the user is currently requesting to move forward.
		 */
		public function get forward() : Boolean
		{
			return current.forward;
		}

		/**
		 * Returns whether the user is currently requesting to move backward.
		 */
		public function get backward() : Boolean
		{
			return current.backward;
		}

		public function get left() : Boolean 
		{
			return current.left;
		}

		public function get right() : Boolean 
		{
			return current.right;
		}

		public function get up() : Boolean 
		{
			return current.up;
		}

		public function get down() : Boolean 
		{
			return current.down;
		}

		public function get space() : Boolean 
		{
			return current.space;
		}

		public function get enter() : Boolean 
		{
			return current.enter;
		}

		public function get control() : Boolean 
		{
			return current.control;
		}

		public function get escape() : Boolean 
		{
			return current.escape;
		}

		public function get f1() : Boolean 
		{
			return current.f1;
		}

		public function get pageUp() : Boolean 
		{
			return current.pageUp;
		}

		public function get pageDown() : Boolean 
		{
			return current.pageDown;
		}

		public function get W() : Boolean
		{
			return current.W;
		}

		public function get S() : Boolean
		{
			return current.S;
		}

		public function get D() : Boolean
		{
			return current.D;
		}

		public function get A() : Boolean
		{
			return current.A;
		}

		public function get K() : Boolean
		{
			return current.K;
		}

		public function get M() : Boolean
		{
			return current.M;
		}

		public function get ONE() : Boolean
		{
			return current.ONE;
		}

		public function get TWO() : Boolean
		{
			return current.TWO;
		}

		public function get f2() : Boolean 
		{
			return current.f2;
		}

		public function get f3() : Boolean 
		{
			return current.f3;
		}

		public function get f4() : Boolean 
		{
			return current.f4;
		}

		public function get f5() : Boolean 
		{
			return current.f5;
		}

		public function get f6() : Boolean 
		{
			return current.f6;
		}

		public function get f7() : Boolean 
		{
			return current.f7;
		}

		public function get f8() : Boolean 
		{
			return current.f8;
		}

		public function get f9() : Boolean 
		{
			return current.f9;
		}

		/**
		 * Returns the user's current mouse x position.
		 */
		public function get mouseX() : Number 
		{
			return current.mouseX;
		}

		/**
		 * Returns the user's current mouse y position.
		 */
		public function get mouseY() : Number 
		{
			return current.mouseY;
		}

		/**
		 * Constructor.<p>
		 * Initialises the instance with the time passed from the <code>GameTimer</code>.
		 */
		public function AbstractUserInput( time : int )
		{
			current = new InputData( );
			previous = new InputData( );
			
			this.time = time;
			
			//GameTimer.getInstance().addEventListener(IntegrationEvent.INTEGRATION_EVENT, update);
		}

		/**
		 * Compares the current state of the user input with the previous state. 
		 * If they differ then resets the previous input to match current.
		 */
		public function update( event : IntegrationEvent = null ) : void
		{
			$hasChanged = false;
			time = event.time;
	
			time++;
		}

		/*public function registerChange(event : Event = null) : void 
		{
			$hasChanged = true;
	    	
	        if ( current.notEquals( previous ) )
	        {
	        	previous = current.copy();
	        	hasChanged = true;	
	        	//dispatchEvent(new UserInputEvent(this));        	
	        }
		}*/

		override public function toString() : String
		{
			var s : String = "User Input\n-----------\n";
			
			s += "forward: " + forward + "\n";
			s += "backward: " + backward + "\n";
			s += "mouseX: " + mouseX + "\n";
			s += "mouseY: " + mouseY + "\n";
			
			return s;
		}
		
		public function get hasChanged() : Boolean
		{
			return $hasChanged;
		}
		
		public function set hasChanged(value:Boolean):void 
		{
			$hasChanged = value;
		}
	}
}