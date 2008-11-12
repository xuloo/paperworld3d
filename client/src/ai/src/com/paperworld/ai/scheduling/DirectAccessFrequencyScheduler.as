package com.paperworld.ai.scheduling 
{
	import de.polygonal.ds.HashMap;
	import de.polygonal.ds.Iterator;	

	/**
	 * @author Trevor
	 */
	public class DirectAccessFrequencyScheduler extends ScheduledObject
	{
		public var sets : HashMap;

		public var frame : int = 0;

		public function DirectAccessFrequencyScheduler()
		{
			super( );
		}

		override public function initialise() : void
		{
			sets = new HashMap( );
		}

		public function addBehaviour(scheduledObject : ScheduledObject) : void
		{
			// Find the correct set.
			var fSet : BehaviourSet = BehaviourSet( sets.find( scheduledObject.frequency ) );
			
			// Add the function to the list.
			HashMap( fSet.functionLists.find( scheduledObject.phase ) ).insert( scheduledObject.frequency, scheduledObject );
		}

		override public function run(time : int = 0) : void
		{
			// Increment the frame number.
			frame++;
			
			// Go through each frequency set.
			var iterator : Iterator = sets.getIterator( );
			
			while(iterator.hasNext( ))
			{
				var behaviourSet : BehaviourSet = BehaviourSet( iterator.next( ) );
				
				// Calculate the phase for this frequency.
				var phase : Number = behaviourSet.frequency % frame;
				
				var behavioursForPhase : HashMap = HashMap( behaviourSet.functionLists.find( phase ) );
				var setIterator : Iterator = behavioursForPhase.getIterator( );
				
				// Runs the behaviours.
				while(setIterator.hasNext( ))
				{
					Scheduleable( setIterator.next( ) ).run( );
				}	
			}	
		}
	}
}
