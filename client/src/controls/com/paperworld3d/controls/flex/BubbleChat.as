package com.paperworld3d.controls.flex
{
	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.rpc.player.RemotePlayer;
	import com.paperworld.rpc.scenes.RemoteScene;
	import com.paperworld.rpc.timer.GameTimer;
	import com.paperworld.rpc.timer.events.IntegrationEvent;
	import com.paperworld.rpc.util.KeyDefinitions;
	import com.paperworld3d.controls.flex.objects.BubbleChatInstance;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.SyncEvent;
	import flash.net.Responder;
	import flash.net.SharedObject;
	
	import jedai.Red5BootStrapper;
	import jedai.events.Red5Event;
	import jedai.net.rpc.Red5Connection;
	import jedai.net.rpc.RemoteSharedObject;
	
	import mx.controls.Button;
	import mx.controls.TextInput;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	
	import org.papervision3d.objects.DisplayObject3D;

	public class BubbleChat extends UIComponent
	{
		private var logger:XrayLog = new XrayLog();
		
		public static var MINIMUM_DISTANCE:Number = 1000;
		
		protected var _remoteCanvas:RemoteCanvas;
		
		protected var _chatInput:TextInput;
		
		protected var _sendButton:Button;
		
		protected var _chatResponder:Responder;
		
		protected var _remoteScene:RemoteScene;
		
		protected var _remoteSharedObject:RemoteSharedObject;
		
		protected var _instances:Array;
		
		protected var _player:RemotePlayer;
		
		protected var _target:DisplayObject3D;
		
		public function set remoteCanvas(value:RemoteCanvas):void 
		{
			logger.info("bubblechat target: " + value);
			_remoteCanvas = value;
			//_remoteScene = value.scene;
		}
		
		public function set player(value:RemotePlayer):void
		{
			logger.info(" bubble chat player: " + value);
			_player = value;
		}
		
		public function set scene(value:RemoteScene):void
		{
			logger.info("bubblechat scene: " + value);
			_remoteScene = value;
		}
		
		public function BubbleChat()
		{
			super();
			
			addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);			
		}
		
		private function onCreationComplete(event:FlexEvent):void
		{
			_instances = new Array();
			_chatResponder = new Responder(chatMessageResponse, chatMessageFailed);
			
			addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			
			var conn:Red5Connection = Red5BootStrapper.getInstance().connection;
			if (conn) 
			{
				connect();
			}
			else
			{
				Red5BootStrapper.getInstance().addEventListener(Red5Event.CONNECTED, connect);
			}
		}
		
		private function onKeyDown(event:KeyboardEvent):void 
		{
			switch (event.keyCode)
			{
				case KeyDefinitions.ENTER:
				{
					onSubmitClick();
					break;
				}
			}
		}
		
		public function connect(event:Event = null):void 
		{
			logger.info("_remoteScene.zone: " + _remoteCanvas.zone);
			_remoteSharedObject = new RemoteSharedObject(_remoteCanvas.zone + "Chat", false, false, Red5BootStrapper.getInstance().connection);
			_remoteSharedObject.addEventListener(SyncEvent.SYNC, onSync)
			
			GameTimer.getInstance().addEventListener(IntegrationEvent.INTEGRATION_EVENT, updateBubbleChatInstances);
		}
		
		private function updateBubbleChatInstances(event:IntegrationEvent):void
		{
			for (var i:String in _instances)
			{
				var instance:BubbleChatInstance = BubbleChatInstance(_instances[i]);
				var player:RemotePlayer = _remoteCanvas.scene.getPlayerByName(i);
				var target:DisplayObject3D = player.avatar.avatar.displayObject;
				var inRange:Boolean = (player == _player) ? true : withinRange(target);
				
				instance.withinRange = inRange;
				
				if (inRange)
				{
					instance.x = (target.screen.x + (_remoteCanvas.width / 2)) - (instance.width / 2);
					instance.y = (target.screen.y + (_remoteCanvas.height / 2));
				}
			}
		}
		
		public function onSync(event:SyncEvent):void 
		{
			var changeList:Array = event.changeList;
			
			var so:SharedObject = RemoteSharedObject(event.target).so();
			var data:Object = so.data;
			
			// loop through the changeList and determine what type of change they are, "clear", "success", "change", "delete", etc...
			for(var i:Number=0; i<changeList.length; i++){
				switch(changeList[i].code) {
					case "clear":
						logger.info("changeList[" + i + "].code: " + changeList[i].code);
						//chat.htmlText = "";
						break;
					case "success":
						logger.info("changeList[" + i + "].code: " + changeList[i].code);
						break;
					case "reject":
						logger.info("changeList[" + i + "].code: " + changeList[i].code);
						break;
					case "change":
						logger.info("changeList[" + i + "].code: " + changeList[i].code);
						//chat.htmlText += so.data[(changeList[i].name)];
						handleNewMessage(data);
						break;
					case "delete":
						logger.info("changeList[" + i + "].code: " + changeList[i].code);
						//chat.htmlText = "";
						break;
				}			
			} 
		}
		
		private function handleNewMessage(data:Object):void 
		{
			for (var i:String in data)
			{
				if (_instances[i] == null)
				{
					var player:RemotePlayer = _remoteCanvas.scene.getPlayerByName(i);
					
					if (player != null)
					{
						var target:DisplayObject3D = _remoteCanvas.scene.getPlayerByName(i).avatar.avatar.displayObject;
						var instance:BubbleChatInstance = new BubbleChatInstance(target);
						_remoteCanvas.addChild(instance);
					
						_instances[i] = instance;
					}
				}
				
				var chatInstance:BubbleChatInstance = BubbleChatInstance(_instances[i]);
				
				if (chatInstance != null)
				{
					chatInstance.setMessages(data[i]);
				}
			}
		}
		
		private function withinRange(target:DisplayObject3D):Boolean
		{
			if (!_target)
			{
				_target = _player.avatar.avatar.displayObject;
			}
			
			var x:Number = target.x - _target.x;
			var y:Number = target.y - _target.y;
			var z:Number = target.z - _target.z;
			
			var distance:Number = Math.sqrt(x * x + y * y + z * z);
			
			return distance < MINIMUM_DISTANCE;
		}
		
		private function onSubmitClick(event:MouseEvent = null) : void 
		{
			var conn:Red5Connection = Red5BootStrapper.getInstance().connection;
			conn.call("chatservice.chatMessage", _chatResponder, _player.username, _remoteCanvas.scene.zone, _chatInput.text);
		
			_chatInput.enabled = false;
		}
		
		public function chatMessageResponse(response:Object):void 
		{
			_chatInput.htmlText = "";
			_chatInput.enabled = true;
		}
		
		public function chatMessageFailed(response:Object):void 
		{		
			for (var i:String in response)
			{
				logger.info(i + " = " + response[i]);
			}
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			
			if (!_chatInput)
			{
				_chatInput = new TextInput();
				_chatInput.setStyle("color", 0x000000);
				addChild(_chatInput);
			}
			
			if (!_sendButton)
	        {
	            _sendButton = new Button();
	            _sendButton.label = "Submit:";
	            _sendButton.addEventListener(MouseEvent.CLICK, onSubmitClick);
	            addChild(_sendButton);
	        }
		}
		
		override protected function measure():void 
		{
			super.measure();
			
			measuredHeight = measuredMinHeight = _chatInput.getExplicitOrMeasuredHeight() + 20;
			measuredWidth = measuredMinWidth = _chatInput.getExplicitOrMeasuredWidth() + _sendButton.getExplicitOrMeasuredWidth() + 20;
		} 
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void 
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			var padding:int = 10;
			var leftPos:int = 10;
			var topPos:int = 10;
			
			_chatInput.setActualSize((unscaledWidth - (padding*2) - _sendButton.getExplicitOrMeasuredWidth()), unscaledHeight - (padding * 2));
			_chatInput.move(leftPos, topPos); 
			
			leftPos = unscaledWidth - _sendButton.getExplicitOrMeasuredWidth() - padding;
			_sendButton.setActualSize(_sendButton.getExplicitOrMeasuredWidth(), _sendButton.getExplicitOrMeasuredHeight());
			_sendButton.move(leftPos, topPos);
		}
	}
}