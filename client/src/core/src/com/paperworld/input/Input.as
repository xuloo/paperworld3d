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
package com.paperworld.input 
{
	import flash.net.registerClassAlias;
	
	import com.paperworld.core.BaseClass;		

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class Input extends BaseClass /*implements IExternalizable*/
	{		
		public var forward : Boolean;

		public function setForward(forward : Boolean) : void
		{
			this.forward = forward;
		}

		public function getForward() : Boolean
		{
			return forward;
		}

		public var back : Boolean;

		public function setBack(back : Boolean) : void
		{
			this.back = back;
		}

		public function getBack() : Boolean
		{
			return back;
		}

		public var turnRight : Boolean;

		public function setTurnRight(turnRight : Boolean) : void
		{
			this.turnRight = turnRight;
		}

		public function getTurnRight() : Boolean
		{
			return turnRight;
		}

		public var turnLeft : Boolean;

		public function setTurnLeft(turnLeft : Boolean) : void
		{
			this.turnLeft = turnLeft;
		}

		public function getTurnLeft() : Boolean
		{
			return turnLeft;
		}

		public var moveRight : Boolean;

		public function setMoveRight(moveRight : Boolean) : void
		{
			this.moveRight = moveRight;
		}

		public function getMoveRight() : Boolean
		{
			return moveRight;
		}

		public var moveLeft : Boolean;

		public function setMoveLeft(moveLeft : Boolean) : void
		{
			this.moveLeft = moveLeft;
		}

		public function getMoveLeft() : Boolean
		{
			return moveLeft;
		}

		public var turnUp : Boolean;

		public function setTurnUp(turnUp : Boolean) : void
		{
			this.turnUp = turnUp;
		}

		public function getTurnUp() : Boolean
		{
			return turnUp;
		}

		public var turnDown : Boolean;

		public function setTurnDown(turnDown : Boolean) : void
		{
			this.turnDown = turnDown;
		}

		public function getTurnDown() : Boolean
		{
			return turnDown;
		}

		public var moveUp : Boolean;

		public function setMoveUp(moveUp : Boolean) : void
		{
			this.moveUp = moveUp;
		}

		public function getMoveUp() : Boolean
		{
			return moveUp;
		}

		public var moveDown : Boolean;

		public function setMoveDown(moveDown : Boolean) : void
		{
			this.moveDown = moveDown;
		}

		public function getMoveDown() : Boolean
		{
			return moveDown;
		}

		public var fire : Boolean;

		public function setFire(fire : Boolean) : void
		{
			this.fire = fire;
		}

		public function getFire() : Boolean
		{
			return fire;
		}

		public var jump : Boolean;

		public function setJump(jump : Boolean) : void
		{
			this.jump = jump;
		}

		public function getJump() : Boolean
		{
			return jump;
		}

		public var mouseX : Number;

		public function setMouseX(mouseX : Number) : void
		{
			this.mouseX = mouseX;
		}

		public function getMouseX() : Number
		{
			return mouseX;
		}

		public var mouseY : Number;

		public function setMouseY(mouseY : Number) : void
		{
			this.mouseY = mouseY;
		}

		public function getMouseY() : Number
		{
			return mouseY;
		}

		public function Input(forward : Boolean = false, back : Boolean = false, 
							  turnRight : Boolean = false, turnLeft : Boolean = false, 
							  moveRight : Boolean = false, moveLeft : Boolean = false, 
							  turnUp : Boolean = false,	turnDown : Boolean = false, 
							  moveUp : Boolean = false, moveDown : Boolean = false, 
							  fire : Boolean = false, jump : Boolean = false, 
							  mouseX : Number = 0, mouseY : Number = 0)
		{
			super();
						
			this.forward 	= forward;
			this.back 		= back;
			this.turnRight 	= turnRight;
			this.turnLeft 	= turnLeft;
			this.moveRight 	= moveRight;
			this.moveLeft 	= moveLeft;
			this.turnUp 	= turnUp;
			this.turnDown 	= turnDown;
			this.moveUp 	= moveUp;
			this.moveDown 	= moveDown;
			this.fire 		= fire;
			this.jump 		= jump;
			this.mouseX 	= mouseX;
			this.mouseY 	= mouseY;
		}
		
		override public function initialise():void 
		{
			registerClassAlias( 'com.paperworld.multiplayer.data.Input', Input );
		}

		public function clone() : Input
		{
			return new Input( forward, back, turnRight, turnLeft, moveRight, moveLeft, turnUp, turnDown, moveUp, moveDown, fire, jump, mouseX, mouseY);
		}

		override public function destroy() : void
		{
			initialise( );
		}

		public function equals(other : Input) : Boolean
		{
			return  forward 	== other.forward && 
					back 		== other.back && 
					turnRight 	== other.turnRight && 
					turnLeft 	== other.turnLeft && 
					moveRight 	== other.moveRight && 
					moveLeft 	== other.moveLeft && 
					turnUp 		== other.turnUp && 
					turnDown 	== other.turnDown && 
					moveUp 		== other.moveUp && 
					moveDown 	== other.moveDown && 
					fire 		== other.fire && 
					jump 		== other.jump && 
					mouseX 		== other.mouseX && 
					mouseY 		== other.mouseY;
		}

		public function notEquals(other : Input) : Boolean
		{
			return !equals( other );	
		}	

		public function equivalentTo(other : Input) : Boolean
		{
			return  forward 	== other.forward || 
					back 		== other.back || 
					turnRight 	== other.turnRight || 
					turnLeft 	== other.turnLeft || 
					moveRight 	== other.moveRight || 
					moveLeft 	== other.moveLeft || 
					turnUp 		== other.turnUp || 
					turnDown 	== other.turnDown || 
					moveUp 		== other.moveUp || 
					moveDown 	== other.moveDown || 
					fire 		== other.fire || 
					jump 		== other.jump;
		}
		
		public function notEquivalentTo(other:Input):Boolean
		{
			return !equivalentTo(other);	
		}

		public function copyFrom(other : Input) : void
		{
			forward 	= other.forward;
			back 		= other.back;
			turnRight 	= other.turnRight;
			turnLeft 	= other.turnLeft;
			moveRight 	= other.moveRight;
			moveLeft 	= other.moveLeft;
			turnUp 		= other.turnUp;
			turnDown 	= other.turnDown;
			moveUp 		= other.moveUp;
			moveDown 	= other.moveDown;
			fire 		= other.fire;
			jump 		= other.jump;			
			mouseX 		= other.mouseX;
			mouseY 		= other.mouseY;
		}
		
		public function toString():String
		{
			return 'Input {\n' + '    turnLeft: ' + turnLeft + '\n    turnRight: ' + turnRight + '\n}';	
		}
	}
}
