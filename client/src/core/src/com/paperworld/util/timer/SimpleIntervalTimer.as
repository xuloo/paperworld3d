package com.paperworld.util.timer 
{ 
    public class SimpleIntervalTimer extends AbstractTimer
    {	
        /**
         * Constructor.
         */
        public function SimpleIntervalTimer()
        {
            super();
        }

        /**
         * Simply callBack the listener and allow setInterval
         * to repeat until stopped.
         */
        override public function update():void
        {
            callBack();
        }
    }
}