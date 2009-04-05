package com.paperworld.flash.util.timer 
{
	import org.springextensions.actionscript.collections.IMap;
	import org.springextensions.actionscript.collections.Map;

	public class TimerManager
    {
        /**
         * The TimerManager instance.
         */
        private static var tm:TimerManager;

        /**
         * Hashtable containing timer id's.
         */
        private static var timers : IMap;

		/**
         * Constructor, private to prevent instantiation.
         */
        public function TimerManager()
        {
            timers = new Map();
		}

        /**
         * Return the singleton instance of the TimerManager class.
         */
        public static function getInstance():TimerManager
        {
            if (tm == null)
            {
                tm = new TimerManager();
            }
	
            return tm;
        }

        /**
         * Add a new timer, return the timer id.
         */
        private function startTimer(timer:Timer, listener:Object, method:Function, rate:Number):Number
        {
            var timerId:Number = timer.startTimer(rate, listener, method);
            timers.put(timerId.toString(), timer);
            return timerId;
        }

        /**
         * Start a simple timer.
         */
        public function startSimpleTimer(listener:Object, method:Function, rate:Number):Number
        {
            var timer:SimpleTimer = new SimpleTimer();
            return startTimer(timer, listener, method, rate);
        }

        /**
         * Start an accurate timer.
         */
        public function startAccurateTimer(listener:Object, method:Function, rate:Number):Number
        {
            var timer:AccurateTimer = new AccurateTimer();
            return startTimer(timer, listener, method, rate);
        }

        /**
         * A simple timer that calls the supplied listener / method
         * at the specified interval until stopped.
         */
        public function startSimpleIntervalTimer(listener:Object, method:Function, rate:Number):Number
        {
            var timer:SimpleIntervalTimer = new SimpleIntervalTimer();
            return startTimer(timer, listener, method, rate);
        }

        /**
         * An accurate interval timer.
         * Calls the supplied listener / method at the specified
         * interval until stopped.
         */
        public function startAccurateIntervalTimer(listener:Object, method:Function, rate:Number):Number
        {
            var timer:AccurateIntervalTimer = new AccurateIntervalTimer();
            return startTimer(timer, listener, method, rate);
        }

        /**
         * Start a countdown timer which will continually update
         * the listener.
         */
        public function startCountdown(listener:CountdownTimerListener, method:Function, rate:Number = 1000):CountdownTimer
        {
            var timer:CountdownTimer = new CountdownTimer();
            startTimer(timer, listener, method, rate);
            return timer;
        }

        /**
         * Start a timed event that will call back the listener with the supplied object
         * after the specified period of time.
         */
        public function startTimedEvent(listener:TimedEventListener, rate:Number, event:Object):Number
        {
            var timer:TimedEvent = new TimedEvent(event);
            return startTimer(timer, listener, null, rate);
        }

        /**
         * Stop a indivtimer with a specific timer id.
         */
        public function stopTimer(timerId:Number):void
        {
            var id:String = timerId.toString();
            /*if (timers.containsKey(id))
            {
            	var timer:Timer = Timer(timers.get(id));
                timer.stopTimer();
                timer.destroy();
                timer = null;
                removeTimer(id);
            }*/
        }

        /**
         * Remove a timer from the timer id list.
         */
        public function removeTimer(timerId:String):void
        {
            timers.remove(timerId);
        }

        /**
         * Stop all timers.
         */
        public function removeAllTimers():void
        {
           /* var timerKeys:Array = timers.getKeySet();
            
            for (var i:Number = 0;i < timerKeys.length; i++)
            {
                stopTimer(timerKeys[i]);
            }*/
	
            timers.clear();
        }

        /**
         * toString.
         *//*
        public function toString():String
        {
            return "TimerManager: TimerIds " + timers.getKeySet();
        }*/
    }
}