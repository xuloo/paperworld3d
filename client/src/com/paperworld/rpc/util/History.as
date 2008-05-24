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
package com.paperworld.rpc.util {
	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.rpc.data.AvatarInput;
	import com.paperworld.rpc.data.AvatarState;
	import com.paperworld.rpc.input.Move;
	import com.paperworld.rpc.objects.RemoteObject;	

	/**
	 * @author Trevor
	 */
	public class History 
	{
		/**
		 * stores all recent moves.
		 */
		//public var moves : CircularBuffer;

		/**
		 * stores recent *important* moves.
		 */
		//public var importantMoves : CircularBuffer;

		private var logger : XrayLog = new XrayLog( );

		/**
		 * History buffer.
		 * 
		 * Stores a history of all "moves" (time, input, state) since the last
		 * correction received from the server, plus a list of all *important moves*
		 * (changes in input) in the same time period.
		 * Used in client side prediction to apply server corrections 'in the past'
		 * 
		 * @author Trevor
		 */
		public function History() 
		{
			
			//moves = new CircularBuffer();	        
			//importantMoves 	= new CircularBuffer();

			movesArray = new Array( );
		}
		
		public function destroy():void 
		{
			head = 0;
			tail = 0;
			
			for (var i:int = 0; i < movesArray.length; i++)
			{
				var move:Move = movesArray[i] as Move;
				move.destroy();
				
				movesArray[i] = null;
			}	
			
			movesArray = new Array();
			movesArray = null;
		}

		private var movesArray : Array;

		private var head : int = -1;

		private var tail : int = 0;

		public function add( move : Move ) : void 
		{
				
			movesArray.push( move );
			head++;
				
				/*var important:Boolean = true;

				if ( !moves.empty() ) {
					
					var previous : Move = moves.newest();
					
					important = move.input.left != previous.input.left ||
								move.input.right != previous.input.right ||
								move.input.forward != previous.input.forward ||
								move.input.back != previous.input.back 
				}

				if ( important )
					importantMoves.add( move );
		
				moves.add( move );*/
		}

		public function next() : Move
		{
			if (tail < head)
			{
				var move : Move = movesArray[tail] as Move;
				tail++;
	    		
				return move;
			}
	    	
			return null;
		}

		/* public function correction( player:Kinematic, t:uint, state : KinematicState, input : KinematicInput ) : void 
		{			
		//logger.info("Rolling back to time: " + t);
		while ((tail < head) && (movesArray[tail] as Move).time < t)
		{
		tail++;
		}
        	
		//logger.info("length after : " + (head - tail));
        	
		if (head == tail)
		{
		//scene._displayObject.snap( state );
		return;
		}
				
		var oldestMove:Move = movesArray[head] as Move;
			
		// if (state.notEquals(oldestMove.state))
		// {	        
		tail++;
				
		var lastMove:Move = movesArray[head] as Move;
		//logger.info("LAST MOVE: " + lastMove.time);
			
		// save current scene data
		//var savedState : KinematicState = scene.state;
		//var savedTime : int = scene.time;
		var savedInput : KinematicInput = player.input.copy();
	
		//logger.info("Setting scene time back to " + player.time + " from " + t);
		// rewind to correction and replay moves	
		player.time = t;
		player.input = input.copy();
		//logger.info("Snapping\n" + state.transform);
		player._displayObject.snap( state.copy() );
		//logger.info("SNAPPED:\n" + player._displayObject.current.transform);
		player.replaying = true;
	            
		//logger.info(movesArray[head] + " --- " + movesArray[tail]);
		//logger.info("replaying " + (movesArray[tail] as Move).time + " ---> " + (movesArray[head] as Move).time);
				
		while( tail < head)
		{
		var move:Move = movesArray[tail] as Move;					

		while (player.time < move.time)
		{
		//logger.info("Scene Time: " + player.time + " Move Time: " + move.time);
		player.update(player.time);
		}
				
		player.input = move.input.copy();
		move.state = player._displayObject.current.copy();
					
		tail++;
		}
		//logger.info("AFTER\n" + scene.state.transform);

		player.update( player.time );
		//logger.info("SCENE TIME::: " + player.time);
		player.replaying = false;	
		player.input = savedInput;
		//}
		}*/

		public function correction( player : RemoteObject, t : uint, state : AvatarState, input : AvatarInput ) : void 
		{
			while ((tail < head) && (movesArray[tail] as Move).time < t)
			{
				tail++;
			}
        	
			//logger.info("length after : " + (head - tail));

			
			if (head == tail)
			{
				//scene._displayObject.snap( state );
				return;
			}
        
			tail++;
				
			var lastMove : Move = movesArray[head] as Move;
			
			if (lastMove != null)
				lastMove.state = state.copy( );
		}

		public function getLastMove() : Move
		{
			return movesArray[tail] as Move;	
		}

		public function getMoveAtTime(t : int) : Move
		{
			for (var i : int = tail; i <= head ; i++)
			{
				var move : Move = movesArray[i] as Move;
	    		
				if (move.time == t)
				{
					return move;
				}
			}
	    	
			return null;	
		}

		public function importantMoveArray( array : Array ) : void 
		{/*
	        var size:int = importantMoves.size();
	        var i:int = importantMoves.tail;
	
	        for ( var j:int = 0; j < size; j++ )
	        {
	            array[j] = importantMoves.getAt(i);
				
				if ( i > moves.moves.length )
					i -= moves.moves.length;
	        }*/
		}
	}
}
