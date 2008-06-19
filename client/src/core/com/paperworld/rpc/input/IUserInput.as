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
	import com.paperworld.rpc.timer.events.IntegrationEvent;		

	/**
	 * <p>The minimum methods/properties needed to handle user input from a device.</p>
	 */
	public interface IUserInput
	{
		/**
		 * Is the user moving forward?
		 */
		function get forward() : Boolean

		/**
		 * Is the user moving backward?
		 */
		function get backward() : Boolean
		
		function get left() : Boolean;

		function get right() : Boolean;

		function get up() : Boolean;

		function get down() : Boolean;

		function get space() : Boolean;

		function get enter() : Boolean;

		function get control() : Boolean;

		function get escape() : Boolean;

		function get f1() : Boolean;

		function get pageUp() : Boolean;

		function get pageDown() : Boolean;

		function get W() : Boolean;

		function get S() : Boolean;

		function get D() : Boolean;

		function get A() : Boolean;

		function get K() : Boolean;

		function get M() : Boolean;

		function get ONE() : Boolean;

		function get TWO() : Boolean;

		function get f2() : Boolean;

		function get f3() : Boolean;

		function get f4() : Boolean;

		function get f5() : Boolean;

		function get f6() : Boolean;

		function get f7() : Boolean;

		function get f8() : Boolean;

		function get f9() : Boolean;
		
		function get hasChanged() : Boolean;
		
		function set hasChanged(value:Boolean):void;

		/**
		 * Returns the mouse x position.
		 */
		function get mouseX() : Number 

		/**
		 * Returns the mouse y position.
		 */
		function get mouseY() : Number

		/**
		 * Called by the <code>GameTimer</code>'s integration event.</br>
		 * Takes a snapshot of the user's input.
		 */
		function update( event : IntegrationEvent = null ) : void 
	}
}