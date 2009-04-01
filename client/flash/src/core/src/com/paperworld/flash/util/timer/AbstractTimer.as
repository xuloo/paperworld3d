package com.paperworld.flash.util.timer 
{
	import flash.utils.clearInterval;	import flash.utils.setInterval;    
	public class AbstractTimer implements Timer
    {
        /**
         * The timerId.
         */
        private var timerId:Number;

        /**
         * The listener object to call back when the timer is complete.
         */
        protected var listener:Object;

        /**
         * The callback method for when the timer is complete.
         */
        private var method:Function;

        /**
         * Constructor, private to prevent direct instantiation.
         */
        public function AbstractTimer()
        {
        }	

        /**
         * Callback the listener via the supplied callback method.
         */	
        protected function callBack():void
        {
            method.call(listener);
        }

        /**
         * Start the timer.
         * Return the timer id.
         * All sub-classes must implement an update method to receive the timer event.
         */
        public function startTimer(milliseconds:Number, listener:Object, method:Function):Number
        {
            this.listener = listener;
            this.method = method;		
			
            // Check if the end time has been reached at reqular intervals.
            timerId = setInterval(update, milliseconds);
            return timerId;
        }

        /**
         * Stop the timer before it would otherwise genuinely expire.
         * Remove the reference to the timerId from the TimerManager singleton.
         * Use as a destroy.
         */	 
        public function stopTimer():void
        {		
            clearInterval(timerId);
            TimerManager.getInstance().removeTimer(timerId.toString());
            timerId = NaN;
        }

        /**
         * Required implentation.
         */
        public function update():void
        {
        }

        /**
         * Destroy any references to listeners and methods
         */
        public function destroy():void
        {		
            listener = null;
            method = null;
        }
    }
}