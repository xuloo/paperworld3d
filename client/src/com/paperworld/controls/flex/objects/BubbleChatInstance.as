package com.paperworld.controls.flex.objects
{
	import com.blitzagency.xray.logger.XrayLog;
	
	import de.polygonal.ds.ArrayedQueue;
	import de.polygonal.ds.Iterator;
	import de.polygonal.ds.LinkedQueue;
	
	import flash.display.Sprite;
	
	import org.papervision3d.objects.DisplayObject3D;

	public class BubbleChatInstance extends Sprite
	{
		public static var MAX_VISIBLE_MESSAGES:int = 3;
		
		private var _target:DisplayObject3D;
		
		private var logger:XrayLog = new XrayLog();
		
		private var bubble:Bubble;
		
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
				
				var chatMessage:ChatMessage = ChatMessage(messages[i]);
				if (!messageExists(chatMessage))
				{
					logger.info("Message doesn't exist");
					addMessage(chatMessage);
					count++;
				}
			}
		}
		
		private function messageExists(message:ChatMessage):Boolean
		{
			logger.info(message.count + " > " + count);
			return message.count <= count;
			/*var exists:Boolean = false;
			
			for (var i:int = 0; i < _chatMessages.length; i++)
			{
				var m:ChatMessage = ChatMessage(_chatMessages[i]);

				if (m == message)
				{
					exists = true;
					break;
				}
			}
			
			return exists;*/
		}
		
		public function addMessage(message:ChatMessage):void 
		{
			logger.info("adding message");
			
			/*if (_bubbles.length > 0)
			{
				removeChild(_bubbles[_bubbles.length - 1]);
			}*/
			
			var bubble:Bubble = new Bubble(message.message);
			
			if (_bubbles.size > 0)
			{
				if (_bubbles.size > MAX_VISIBLE_MESSAGES - 1)
				{
					var remove:Bubble = _bubbles.dequeue() as Bubble;
					removeChild(remove);
				}
				
				var iterator:Iterator = _bubbles.getIterator();
				
				while(iterator.hasNext())
				{
					var b:Bubble = iterator.next() as Bubble;
					b.y -= bubble.height;
				}
			}

			
			_bubbles.enqueue(bubble);
			
			
			addChild(bubble);					
		}
		
	}
}