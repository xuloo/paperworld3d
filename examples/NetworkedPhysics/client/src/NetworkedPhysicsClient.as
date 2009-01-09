package  
{
	import org.cove.ape.APEngine;
	
	import flash.display.Sprite;			

	/**
	 * @author Trevor
	 */
	public class NetworkedPhysicsClient extends Sprite 
	{
		public function NetworkedPhysicsClient()
		{
			APEngine.init(1/4);
		}
	}
}
