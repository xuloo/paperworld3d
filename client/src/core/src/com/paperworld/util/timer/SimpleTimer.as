package com.paperworld.util.timer 
{ 
    public class SimpleTimer extends AbstractTimer
    {
        /**
         * Constructor.
         */
        public function SimpleTimer()
        {
            super();
        }

        /**
         * Simply call back the listener and end the setInterval event.
         */
        override public function update():void
        {
            stopTimer();
            callBack();
            destroy();
        }
    }
}