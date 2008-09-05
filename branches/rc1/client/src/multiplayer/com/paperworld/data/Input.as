package com.paperworld.data 
{
	import flash.utils.IDataInput;

	 * @author Trevor
	 */
	public class Input extends BaseClass implements IExternalizable
	{
		public var forward : Boolean;












		{
			forward = false;
			back = false;
			turnRight = false;
			turnLeft = false;
			moveRight = false;
			moveLeft = false;
			turnUp = false;
			turnDown = false;
			moveUp = false;
			moveDown = false;
			fire = false;
			jump = false;
		}

		{
			initialise( );
		}

		{
			if (!super.equals( other )) return false;
			
			var o : Input = Input( other );
			
			return forward == o.forward && back == o.back && turnRight == o.turnRight && turnLeft == o.turnLeft && moveRight == o.moveRight && moveLeft == o.moveLeft && turnUp == o.turnUp && turnDown == o.turnDown && moveUp == o.moveUp && moveDown == o.moveDown && fire == o.fire && jump == o.jump;
		}

		{
			forward = input.readBoolean( );
			back = input.readBoolean( );
			turnRight = input.readBoolean( );
			turnLeft = input.readBoolean( );
			moveRight = input.readBoolean( );
			moveLeft = input.readBoolean( );
			turnUp = input.readBoolean( );
			turnDown = input.readBoolean( );
			moveUp = input.readBoolean( );
			moveDown = input.readBoolean( );
			fire = input.readBoolean( );
			jump = input.readBoolean( );
		}

		{
			output.writeBoolean( forward );
			output.writeBoolean( back );
			output.writeBoolean( turnRight );
			output.writeBoolean( turnLeft );
			output.writeBoolean( moveRight );
			output.writeBoolean( moveLeft );
			output.writeBoolean( turnUp );
			output.writeBoolean( turnDown );
			output.writeBoolean( moveUp );
			output.writeBoolean( moveDown );
			output.writeBoolean( fire );
			output.writeBoolean( jump );
		}
	}
}