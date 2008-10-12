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
package com.paperworld.util 
{
	import com.blitzagency.xray.logger.XrayLog;	
	
	import org.pranaframework.utils.Assert;

	import com.paperworld.core.BaseClass;		

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class CircularBuffer extends BaseClass
	{
		public var logger : XrayLog = new XrayLog();

		public var head : int;

		public var tail : int;

		public var index : int;

		public var moves : Array;

		public function CircularBuffer()
		{
			super( );
		}

		override public function initialise() : void
		{
			index = 0;

			resize( 200 );
		}

		public function resize(size : int) : void
		{
			head = 0;
			tail = 0;
			moves = new Array( size );
		}

		public function get size() : int
		{
			var count : int = head - tail;
			
			if (count < 0) count += moves.length;
                
			return count;
		}

		public function add(move : Move) : void
		{
			moves[head] = move;

			head++;
			if (head >= moves.length) 
                head -= moves.length;
		}

		public function remove() : void
		{
			if (!empty())
			{
				tail++;
				if (tail >= moves.length) 
                	tail -= moves.length;
			}
		}

		public function oldest() : Move
		{
			//logger.info("oldest: " + moves[tail]);
			return moves[tail];
		}

		public function newest() : Move
		{
			//Assert.state( !empty( ), "Expecting CircularBuffer to contain Moves." );
			var index : int = head - 1;
			if (index == -1)
                index = moves.length - 1;
			return moves[index];
		}

		public function empty() : Boolean
		{
			return head == tail;
		}

		public function next(index : int) : void
		{
			index++;
			if (index >= moves.length) 
                index -= moves.length;
		}

		public function previous(index : int) : void
		{
			index--;
			if (index < 0)
                index += moves.length;
		}

		public function toString() : String
		{
			return 'CBuffer[size = ' + size + ']';
		}
	}
}
