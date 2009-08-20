package {
	import com.joeberkovitz.moccasin.service.IOperation;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.net.Responder;
	
	import org.paperworld.flash.api.connection.IClient;
	import org.paperworld.flash.connection.Red5Connection;
	import org.paperworld.flash.connection.RemoteSharedObject;
	import org.paperworld.flash.connection.client.BasicClient;
	import org.paperworld.flash.core.objects.State;
	import org.paperworld.flash.multiplayer.messages.ServerSyncMessage;
	import org.paperworld.flash.multiplayer.sync.SynchronisationManager;
	import org.paperworld.flash.utils.input.Input;

	public class HelloPaperworldFlash extends Sprite
	{
		private var client:IClient;
		
		private var syncManager:SynchronisationManager;
		
		public function HelloPaperworldFlash()
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
