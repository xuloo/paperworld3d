package com.paperworld.flash.util.timer 
{
	import flash.utils.getTimer;    	

	public class AccurateTimer extends AbstractTimer
    {
        /**
         * The update frequency.
         */
        private static var TIMER_UPDATE_FREQ:Number = 100;

        /**
         * The time this timer will expire at.
         */
        protected var endTime:Number;

        /**
         * Constructor.
         */
        public function AccurateTimer()
        {
            super();
        }

        /**
         * Start the timer.
         * Return the timer id.
         */
        override public function startTimer(milliseconds:Number, listener:Object, method:Function):Number
        {
            setEndTime(milliseconds);
            return super.startTimer(TIMER_UPDATE_FREQ, listener, method);
        }

        /**
         * Return the time remaining in ms.
         */
        public function getTimeRemaining():Number
        {
            return endTime - getTimer();
        }

        /**
         * Set the endtime.
         * Time supplied in milliseconds.
         */
        protected function setEndTime(timeRemaining:Number):void
        {
            endTime = timeRemaining + getTimer();
        }

        /**
         * Check if the timer should expire.
         * If expired inform the listener and stop the timer.
         * If not continue timer.
         * Stop timer immeadiately and remove timerId from TimerManager singleton.
         */
        override public function update():void
        {
            if (getTimer() > endTime)
            {
                stopTimer();
				
                callBack();

                destroy();
            }
        }
    }
}