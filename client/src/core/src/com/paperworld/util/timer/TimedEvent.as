package com.paperworld.util.timer 
{
    public class TimedEvent extends AccurateTimer
    {
        /**
         * The event to be passed to the listener when the timer has expired.
         */
        private var event:Object;

        /**
         * Constructor.
         */
        public function TimedEvent(event:Object)
        {
            super();
            this.event = event;
        }	

        /**
         * Overrides the AbstractTimer callback method.
         */
        override protected function callBack():void
        {
            TimedEventListener(listener).notify(event);
        }

        /**
         * Overrides the AbstractTimer destroy method.
         */
        override public function destroy():void
        {
            event = null;
            super.destroy();
        }	
    }
}