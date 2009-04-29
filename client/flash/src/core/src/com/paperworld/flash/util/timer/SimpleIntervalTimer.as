package com.paperworld.flash.util.timer 
{ 
    public class SimpleIntervalTimer extends AbstractTimer
    {	
        /**
         * Constructor.
         */
        public function SimpleIntervalTimer(delay:int, repeatCount:int = 0)
        {
            super(delay, repeatCount);
        }
    }
}