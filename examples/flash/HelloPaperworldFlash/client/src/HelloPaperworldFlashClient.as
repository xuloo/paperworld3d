package {
	import com.joeberkovitz.moccasin.service.IOperation;
	import com.paperworld.flash.api.multiplayer.IClient;
	import com.paperworld.flash.multiplayer.connection.Red5Connection;
	import com.paperworld.flash.multiplayer.connection.RemoteSharedObject;
	import com.paperworld.flash.multiplayer.connection.client.BasicClient;
	import com.paperworld.flash.multiplayer.connection.messages.ServerSyncMessage;
	import com.paperworld.flash.multiplayer.data.State;
	import com.paperworld.flash.multiplayer.sync.SynchronisationManager;
	import com.paperworld.flash.util.input.Input;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.net.Responder;

	public class HelloPaperworldFlashClient extends Sprite
	{
		private var client:IClient;
		
		private var syncManager:SynchronisationManager;
		
		public function HelloPaperworldFlashClient()
		{
			trace("Creation Complete");
				
			var connection:Red5Connection = new Red5Connection();
			connection.connectionArgs = ["this","that"];
			connection.rtmpURI = "rtmp://localhost/HelloWorldMultiplayer";
			
			client = new BasicClient(connection);
			client.sharedObject = new RemoteSharedObject("avatars", connection);
			
			syncManager = new SynchronisationManager();
			syncManager.client = client;
			
			client.addMessageProcessor(syncManager);
						
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
			
			var message:ServerSyncMessage = new ServerSyncMessage();
			message.senderId = "ME!";
			//var op:IOperation = client.sendToServer(message);
			//op.execute();
			
			client.connection.call("multiplayer.receiveMessage", new Responder(onResponse, onFault), new Input());
			client.connection.call("multiplayer.receiveMessage", new Responder(onResponse, onFault), new State());
			client.connection.call("multiplayer.receiveMessage", new Responder(onResponse, onFault), message);
			//var localAvatar:ISynchronisedAvatar = new LocalAvatar();
			//syncManager.register(localAvatar);
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
