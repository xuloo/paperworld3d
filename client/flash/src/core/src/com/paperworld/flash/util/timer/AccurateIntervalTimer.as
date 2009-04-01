package com.paperworld.flash.util.timer 
{
	import flash.utils.getTimer;    

	public class AccurateIntervalTimer extends AccurateTimer
    {
        /**
         * Interval time.
         */
        private var intervalTime:Number;

        /**
         * Constructor.
         */
        public function AccurateIntervalTimer()
        {
            super();
        }

        /**
         * Start the timer.
         * Over-ride AccurateTimer implementation to
         * intercept and store the interval frequency value 
         * in order to reschedule.
         */
        override public function startTimer(intervalTime:Number, listener:Object, method:Function):Number
        {
            this.intervalTime = intervalTime;
            return super.startTimer(intervalTime, listener, method);
        }

        /**
         * Override AccurateTimer implementation.
         * Don't stop the timer until requested.
         * Reset a new endTime using the existing endTime as
         * the start point.
         * This will eliminate inaccuracies from end time checking.
         */
        override public function update():void
        {
            if (getTimer() > endTime)		
            {
                endTime += intervalTime;
                callBack();
            }
        }
    }
}