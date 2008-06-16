package com.paperworld3d.controls.flex.objects
{
	import caurina.transitions.Tweener;
	
	import com.blitzagency.xray.logger.XrayLog;
	
	import de.polygonal.ds.ArrayedQueue;
	
	import flash.display.Sprite;
	
	import org.papervision3d.objects.DisplayObject3D;

	public class BubbleChatInstance extends Sprite
	{
		public static var MAX_VISIBLE_MESSAGES:int = 3;
		
		private var _target:DisplayObject3D;
		
		private var logger:XrayLog = new XrayLog();
		
		private var _bubble:Bubble;
		
		private var _chatMessages:Array;
		
		private var count:int = -1;
		
		private var _bubbles:ArrayedQueue;
		
		public function BubbleChatInstance(target:DisplayObject3D)
		{
			super();
			
			logger.info("creating bubble chat instance");
			
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
					logger.info("Message doesn't exist");
					addMessage(chatMessage);
					count++;
				}
			}
		}
		
		private function messageExists(message:Object):Boolean
		{
			logger.info(message["count"] + " > " + count);
			return message["count"] <= count;
		}
		
		public function addMessage(message:Object):void 
		{
			logger.info("addMessage()");
			if (_bubble)
			{
				logger.info("already have a bubble - destroying it");
				destroyBubble(_bubble, message);
			}
			else
			{
				logger.info("No bubble right now - just create one");
				createNewBubble(message);
			}
			
		}
		
		public function destroyBubble(bubble:Bubble, message:Object):void 
		{
			logger.info("destroyBubble()");
			Tweener.addTween(bubble, {scaleX: 0, scaleY: 0, time: 0.3, onCompleteScope: this, onComplete:onDestroyComplete, onCompleteParams:[bubble, message]});
			
		}
		
		public function onDestroyComplete(bubble:Bubble, message:Object):void 
		{
			logger.info("destruction of bubble complete");
			removeChild(_bubble);
			
			createNewBubble(message);
		}
		
		public function createNewBubble(message:Object):void 
		{
			logger.info("createNewBubble()");				
			_bubble = new Bubble(message["message"]);
			
			_bubble.width = _bubble.height = 0;
			
			Tweener.addTween(_bubble, {scaleX:1, scaleY:1, time: 0.3});
			
			addChild(_bubble);
		}
		
	}
}