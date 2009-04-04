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
package com.paperworld.flash.util
{
	import com.paperworld.api.ISynchronisedAvatar;
	import com.paperworld.flash.input.Input;
	import com.paperworld.flash.multiplayer.data.State;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class History
	{
		private static var logger:ILogger = LoggerFactory.getLogger("Paperworld");
		
		public var moves : CircularBuffer;

		public var importantMoves : CircularBuffer;

		public function History(size : int = 200)
		{
			super( );
			
			moves.resize( size );
			importantMoves.resize( size );
		}

		public function initialise() : void
		{
			moves = new CircularBuffer( );
			importantMoves = new CircularBuffer( );	
		}

		public function destroy() : void
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

		public function correction(avatar : ISynchronisedAvatar, t : int, state : State, input : Input) : void
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
				var	savedInput : Input = avatar.getInput( ).clone( );
	
				// rewind to correction and replay moves
				avatar.setTime( t );
				avatar.setInput( input );

				avatar.snap( state );
				
				avatar.setReplaying( true );
	
				var i : int = moves.tail;

				while (i != moves.head)
				{
					var next : Move = Move( moves.moves[i] );

					if (next)
					{						
						while (avatar.getTime( ) < moves.moves[i].time)
						{
							avatar.update( );
						}
					
						avatar.setInput( moves.moves[i].input );
						moves.moves[i].state = avatar.getState( );
					}
					
					i++;
					if (i > 1000) i = 0;
				}

				//syncObject.update( );

				avatar.setReplaying( false );
	
				// restore saved input
				avatar.setInput( savedInput );
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
