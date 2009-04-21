package {
	import com.joeberkovitz.moccasin.service.IOperation;
	import com.paperworld.flash.api.multiplayer.IClient;
	import com.paperworld.flash.api.multiplayer.IMessage;
	import com.paperworld.flash.multiplayer.connection.Red5Connection;
	import com.paperworld.flash.multiplayer.connection.client.BasicClient;
	import com.paperworld.flash.multiplayer.connection.messages.BaseMessage;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.net.Responder;

	public class HelloPaperworldFlashClient extends Sprite
	{
		private var client:IClient;
		
		public function HelloPaperworldFlashClient()
		{
			trace("Creation Complete");
				
			var connection:Red5Connection = new Red5Connection();
			connection.connectionArgs = ["this","that"];
			connection.rtmpURI = "rtmp://localhost/HelloWorldMultiplayer";
			
			client = new BasicClient(connection);
			
			var connect:IOperation = client.connect();
			connect.addEventListener(Event.COMPLETE, onConnectionEstablished);
			connect.execute();
		}
		
		private function onNetStatus(e:NetStatusEvent):void 
		{
			trace("NetStatus: " + e.info.code);
		}
		
		private function onConnectionEstablished(event:Event):void 
		{
			trace("connection established");
			
			var message:IMessage = new BaseMessage();

			var sendOp:IOperation = client.sendToServer(message);
			sendOp.execute();
		}
		
		private function onResponse(response:Object):void 
		{
			trace("response: " + response);
			
			for (var i:String in response)
			{
				trace(i + " => " + response[i]);
			}
		}
		
		private function onFault(fault:Object):void 
		{
			trace("response: " + fault);
			
			for (var i:String in fault)
			{
				trace(i + " => " + fault[i]);
			}
		}
	}
}
