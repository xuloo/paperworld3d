package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
	import flash.net.registerClassAlias;
	
	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.input.Input;		

	/**
	 * @author Trevor
	 */
	public class KeyControlExampleClient extends Sprite 
	{
		private var logger : XrayLog = new XrayLog( );

		private var nc : NetConnection;

		public function KeyControlExampleClient()
		{
			logger.info( "KeyControlExampleClient" );
			
			registerClassAlias('com.paperworld.multiplayer.data.Input', Input );

			nc = new NetConnection();
			nc.client = this;
			nc.addEventListener( NetStatusEvent.NET_STATUS, onConnectedToServer);
			nc.connect('rtmp://localhost/HelloPaperWorld', 'trev', 'password');
		}
		
		public function setClientID(value:String):void
		{
			
		}

		public function onContextLoaded(event : Event) : void 
		{
			logger.info( "Context Loaded connecting" );
		}

		public function onConnectedToServer(event : NetStatusEvent) : void
		{
			//logger.info( "Connected To Server " + event.info.code + " gettin gmy objedt");
			//logger.info("getting my object");
			//if (event.info.code == "NetConnection.Connect.Success")
			//{
				
				getMyObject();
			//}
			//var responder : Responder = new Responder( onResult, onStatus );
			//scene.connection.call( 'echo', responder, new MyClass( ) );
			
		}

		// call server-side method
		public function getMyObject() : void 
		{
			//logger.info("getting object");
			// create a responder set to callback
			var resp : Responder = new Responder( onResult, onStatus );
			// call the server side method
			logger.info( "getMyObject" );
			nc.call( "multiplayer.receiveInput", resp, "0", 0, new Input( ) );
		}

		public function onResult(result : int) : void
		{
			logger.info( "result: " + result );
		}

		public function onStatus(status : Object) : void 
		{
			for (var i:String in status)
			{
				logger.info( i + " = " + status[i] );
			}
		}
	}
}
