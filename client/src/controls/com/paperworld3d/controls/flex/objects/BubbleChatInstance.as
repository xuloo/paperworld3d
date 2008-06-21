package com.paperworld3d.controls.flex.objects
{
	import caurina.transitions.Tweener;
	
	import com.blitzagency.xray.logger.XrayLog;
	
	import de.polygonal.ds.ArrayedQueue;
	
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.papervision3d.objects.DisplayObject3D;

	public class BubbleChatInstance extends Sprite
	{
		public static var MAX_VISIBLE_MESSAGES:int = 3;
		
		public static var MAX_BUBBLE_DISPLAY_TIME:Number = 5000;
		
		private var _target:DisplayObject3D;
		
		private var logger:XrayLog = new XrayLog();
		
		private var _bubble:Bubble;
		
		private var _chatMessages:Array;
		
		private var _currentMessage:Object;
		
		private var count:int = -1;
		
		private var _bubbles:ArrayedQueue;
		
		private var _withinRange:Boolean = false;
		private var displayTimeOut:Timer;
		
		public function set withinRange(value:Boolean):void 
		{	
			if (_withinRange != value )
			{
				_withinRange = value;
				
				if (_withinRange && _currentMessage)
					addMessage(_currentMessage);
				else
					destroyBubble(_bubble, null, false);
			}								
		}
		public function BubbleChatInstance(target:DisplayObject3D)
		{
			super();
			
			logger.info("creating bubble chat instance");
			
			displayTimeOut = new Timer(MAX_BUBBLE_DISPLAY_TIME, 1);
			displayTimeOut.addEventListener(TimerEvent.TIMER_COMPLETE, onTimeOut);
			
			_chatMessages = new Array();
			_bubbles = new ArrayedQueue(8);
			_target = target;
		}
		
		public function setMessages(messages:Object):void 
		{
			for (var i:String in messages)
			{
				logger.info(i + " => " + messages[i]);
				
				var chatMessage:Object = messages[i];
				if (!messageExists(chatMessage))
				{
					_currentMessage = chatMessage;
					
					if (_withinRange)
					{
						addMessage(chatMessage);
						
					}
					
					count++;
				}
			}
		}
		
		private function messageExists(message:Object):Boolean
		{
			return message["count"] <= count;
		}
		
		public function addMessage(message:Object):void 
		{
			if (_bubble)
			{
				destroyBubble(_bubble, message, true);
			}
			else if (_withinRange)
			{
				createNewBubble(message);
			}
			
		}
		
		public function destroyBubble(bubble:Bubble, message:Object = null, nextMessage:Boolean = false):void 
		{
			if (nextMessage)
			{
				Tweener.addTween(bubble, {scaleX: 0, scaleY: 0, time: 0.3, onCompleteScope: this, onComplete:onDestroyComplete, onCompleteParams:[bubble, message]});
			}
			else
			{
				Tweener.addTween(bubble, {scaleX: 0, scaleY: 0, time: 0.3});
			}
		}
		
		public function onDestroyComplete(bubble:Bubble, message:Object):void 
		{
			removeChild(bubble);			
			createNewBubble(message);
		}
		
		public function createNewBubble(message:Object):void 
		{			
			_bubble = new Bubble(message["message"]);
			
			_bubble.width = _bubble.height = 0;
			
			Tweener.addTween(_bubble, {scaleX:1, scaleY:1, time: 0.3});
			
			addChild(_bubble);
			
			startTimeOut();
		}
		
		private function startTimeOut():void 
		{
			displayTimeOut.start();
		}
		
		private function stopTimeOut():void 
		{
			displayTimeOut.stop();
		}
		
		private function restartTimeOut():void
		{
			stopTimeOut();
			startTimeOut();
		}
		
		private function onTimeOut(event:TimerEvent = null):void 
		{
			if (_bubble)
			{
				destroyBubble(_bubble);	
				stopTimeOut();
			}
		}
		
	}
}