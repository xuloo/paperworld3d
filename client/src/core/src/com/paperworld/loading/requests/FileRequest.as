package com.paperworld.loading.requests 
{
	import com.paperworld.core.context.CoreContext;	

	import flash.events.Event;
	import flash.events.ProgressEvent;

	import com.paperworld.core.EventDispatchingBaseClass;
	import com.paperworld.loading.FileTypeMapper;
	import com.paperworld.loading.loaders.FileLoader;
	import com.paperworld.util.ClassDefinitions;		

	/**
	 * @author Trevor
	 */
	public class FileRequest extends EventDispatchingBaseClass 
	{		
		protected var _loader : FileLoader;

		public var url : String;

		public function FileRequest(url : String)
		{
			super( this );
			
			this.url = url;
		}

		override public function initialise() : void
		{
			initialiseLoader( );
			initialiseListeners( );
		}

		public function initialiseLoader() : void
		{
			var mapper : FileTypeMapper = CoreContext.getInstance( ).getObject( ClassDefinitions.FILE_TYPE_MAPPER ) as FileTypeMapper;
			
			_loader = mapper.getLoader( url );
		}

		public function initialiseListeners() : void
		{
			_loader.addEventListener( Event.OPEN, onOpen );
			_loader.addEventListener( ProgressEvent.PROGRESS, onProgress );
			_loader.addEventListener( Event.COMPLETE, onComplete );	
		}

		public function load() : void
		{
		}

		public function get bytesLoaded() : Number
		{
			return _loader.getBytesLoaded( );	
		}

		public function get bytesTotal() : Number
		{
			return _loader.getBytesTotal( );	
		}

		public function get data() : *
		{
			return _loader.getData( );
		}

		protected function onOpen(event : Event) : void
		{
		}

		protected function onProgress(event : Event) : void
		{
		}

		protected function onComplete(event : Event) : void
		{
		}
	}
}
