package {
		
	import flash.display.Sprite;
	
	import org.springextensions.actionscript.context.support.ResourceAwareApplicationContext;
	import org.springextensions.actionscript.mvcs.service.operation.LibraryFileLoadOperation;
	import org.springextensions.actionscript.mvcs.service.operation.LoaderOperation;
	import org.springextensions.actionscript.mvcs.service.operation.event.AsyncOperationEvent;
	import org.springextensions.actionscript.mvcs.service.operation.event.AsyncOperationResultEvent;
	import org.springextensions.actionscript.mvcs.service.operation.events.OperationProgressEvent;
	import org.springextensions.actionscript.mvcs.service.operation.events.ProgressSourceEvent;
	

	public class hellopaperworld_singleplayer_flash extends Sprite
	{		
		private var lib:LibraryFileLoadOperation;
		private var lo:LoaderOperation;
		
		public function hellopaperworld_singleplayer_flash()
		{
			//Bootstrapper.getInstance(this).load("hellopaperworld");
			
			var context:ResourceAwareApplicationContext = new ResourceAwareApplicationContext("space.xml")
			context.addEventListener(ProgressSourceEvent.PROGRESS_START, onContextStart);
			context.addEventListener(OperationProgressEvent.PROGRESS, onContextProgress);
			context.addEventListener(AsyncOperationEvent.RESULT, onContextReady);
			context.load();
		}
		
		private function onContextStart(e:ProgressSourceEvent):void 
		{
			trace("Context Loading " + e.source);
		}
		
		private function onContextProgress(e:OperationProgressEvent):void 
		{
			trace("Context Progress: " + e.progress);
		}
		
		private function onContextReady(e:AsyncOperationResultEvent):void 
		{
			trace("Context Ready");
		}
	}
}
