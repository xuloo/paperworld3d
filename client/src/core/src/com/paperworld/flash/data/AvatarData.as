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
package com.paperworld.flash.data 
{
	import com.actionengine.flash.core.BaseClass;			

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class AvatarData extends BaseClass 
	{
		public var ref : String;

		public var time : int;

		public var id : String;

		public function AvatarData()
		{
			super( );
		}

		public function getRef() : String
		{
			return ref;
		}

		public function setRef(ref : String) : void
		{
			this.ref = ref;
		}

		public function getTime() : int
		{
			return time;
		}

		public function setTime(time : int) : void
		{
			this.time = time;
		}

		public function getId() : String
		{
			return id;
		}

		public function setId(id : String) : void
		{
			this.id = id;
		}

		public function toString() : String
		{
			return 'AvatarData {\n    ref: ' + ref + '\n    time: ' + time + '\n    id: ' + id + '\n}';	
		}
	}
}
