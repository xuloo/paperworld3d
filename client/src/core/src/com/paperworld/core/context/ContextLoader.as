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
package com.paperworld.core.context 
{
	import flash.events.Event;
	
	import org.pranaframework.context.support.XMLApplicationContext;
	
	import com.paperworld.core.EventDispatchingBaseClass;	

	/**
	 * Base Class for classes that need to load Prana object definition files. handles loading 
	 * the required context(s) and informs listeners when load/parse complete.
	 * 
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class ContextLoader extends EventDispatchingBaseClass 
	{
		/**
		 * Flagged true if the application context for this scene (the Prana Definitions file that contains the
		 * objects that this scene needs to operate) has been loaded and parsed.
		 */
		protected var _contextLoaded : Boolean;

		/**
		 * The access point to the Prana Definitions this scene needs to operate.
		 */
		protected var _applicationContext : XMLApplicationContext;
		
		public var context : String;
		
		public function ContextLoader()
		{
			super( );
		}
		
		override public function initialise():void
		{
			_contextLoaded = false;
		}

		/**
		 * Load the Prana Definitions file this scene requires to operate.
		 */
		public function loadContext(context : String) : void
		{			
			_applicationContext = new XMLApplicationContext( context );
			_applicationContext.addEventListener( Event.COMPLETE, onContextLoaded );
			_applicationContext.load( );
		}

		/**
		 * Called when the context file has been loaded.
		 * Flags the context as having been loaded.
		 * If we're in the process of connecting (ie. the connect() method has been called) then continue.
		 */
		protected function onContextLoaded(event : Event) : void
		{			
			_contextLoaded = true;
		}
	}
}
