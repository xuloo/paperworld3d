package com.paperworld.controls.flex
{
	import com.blitzagency.xray.logger.XrayLog;
	
	import flash.events.SyncEvent;
	
	import jedai.Red5BootStrapper;
	import jedai.net.rpc.Red5Connection;
	import jedai.net.rpc.RemoteSharedObject;
	
	import mx.collections.ArrayCollection;
	import mx.controls.TileList;
	import mx.core.ClassFactory;
	import mx.events.FlexEvent;

	public class PlayerList extends TileList
	{
		private var players:ArrayCollection = new ArrayCollection();
		
		private var logger:XrayLog = new XrayLog();
		
		public function PlayerList()
		{
			super();
			
			addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
		}
		
		private function onCreationComplete(event:FlexEvent):void 
		{
			this.itemRenderer = new ClassFactory(PlayerListItemRenderer);
		}
		
		public function connect(scene:String):void 
		{
			var connection:Red5Connection = Red5BootStrapper.getInstance().connection;
			logger.info("connecting to RSO: " + (scene + "_players"));
			var remoteSharedObject:RemoteSharedObject = new RemoteSharedObject(scene + "_players", false, false, connection);
			remoteSharedObject.addEventListener(SyncEvent.SYNC, onSync);
		}
		
		private function onSync(event:SyncEvent):void 
		{
			var list:Array = event.changeList;
			logger.info("event.changeList.length: " + event.changeList.length);
			
			for(var i:Number=0; i<list.length; i++){
				switch(list[i].code) {
					case "clear":
						logger.info("list[" + i + "].code: " + list[i].code);
						break;
					case "success":
						logger.info("list[" + i + "].code: " + list[i].code);
						break;
					case "reject":
						logger.info("list[" + i + "].code: " + list[i].code);
						break;
					case "change":
						logger.info("list[" + i + "].code: " + list[i].code);
						players.removeAll();
						
						var so:SharedObject = RemoteSharedObject(event.target).so();
						for (var key:String in so.data)
						{
						    logger.info(key + ": " + so.data[key]);
						    players.addItem(so.data[key]);
						}
									
						break;
					case "delete":
						players.removeAll();
						
						for (var key1:String in event.target.so.data)
						{
						    logger.info(key1 + ": " + event.target.so.data[key1]);
						    players.addItem(so.data[key1]);
						}
						
						logger.info("list[" + i + "].code: " + list[i].code);
						break;
				}			
			} 
			
			logger.info("This scene has " + players.length  + " players connected");
			dataProvider = players;
		}
		
	}
}