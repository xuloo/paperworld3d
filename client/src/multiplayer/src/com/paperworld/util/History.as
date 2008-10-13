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
	import com.paperworld.core.BaseClass;
	import com.paperworld.input.Input;
	import com.paperworld.multiplayer.data.State;
	import com.paperworld.multiplayer.objects.SyncObject;	

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class History extends BaseClass
	{
		public var moves : CircularBuffer;

		public var importantMoves : CircularBuffer;

		private var logger : XrayLog = new XrayLog( );

		public function History(size : int = 200)
		{
			super( );
			
			moves.resize( size );
			importantMoves.resize( size );
		}

		override public function initialise() : void
		{
			moves = new CircularBuffer( );
			importantMoves = new CircularBuffer( );	
		}

		override public function destroy() : void
		{
		}

		public function add(move : Move) : void
		{	
			// determine if important move
			var important : Boolean = true;

			if (!moves.empty( ))
			{
				var previous : Move = moves.newest( );

				important = move.input.notEquivalentTo( previous.input );
			}
	
			if (important)
	            importantMoves.add( move );
	
			// add move to history
			moves.add( move );
		}

		public function correction(syncObject : SyncObject, t : int, state : State, input : Input) : void
		{
			// discard out of date important moves 
			/*if (importantMoves.oldest( ))
			{
			while (importantMoves.oldest( ).time < t && !importantMoves.empty( ))
			importantMoves.remove( );
			}*/

			try 
			{
				while (moves.oldest( ).time < t && !moves.empty( ))
	           			moves.remove( );
			}
			catch( e : Error ) 
			{
			}

			if (moves.empty( ))
	            return;
	
			// compare correction state with move history state
			if (state.notEquals( moves.oldest( ).state ))
			{
				// discard corrected move
				moves.remove( );
	
				// save current scene data
				var	savedInput : Input = syncObject.input.clone( );
	
				// rewind to correction and replay moves
				syncObject.time = t;
				syncObject.input = input;

				syncObject.snap( state );
	
				syncObject.replaying = true;
	
				var i : int = moves.tail;

				while (i != moves.head)
				{
					var next : Move = Move( moves.moves[i] );

					if (next)
					{						
						while (syncObject.time < moves.moves[i].time)
						{
							syncObject.update( );
						}
					
						syncObject.input = moves.moves[i].input;
						moves.moves[i].state = syncObject.state;
					}
					
					i++;
					if (i > 1000) i = 0;
				}

				//syncObject.update( );

				syncObject.replaying = false;
	
				// restore saved input
				syncObject.input = savedInput;
			}
		}

		public function importantMoveArray(array : Array) : void
		{
			var size : int = importantMoves.size;
	
			array = new Array( size );
	
			var i : int = importantMoves.tail;
	
			for (var j : int = 0; j < size ; j++)
			{
				array[j] = importantMoves[i];
				importantMoves.next( i );
			}
		}
	}
}
