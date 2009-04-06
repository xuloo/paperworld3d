package com.paperworld.flash.core.loading.actions
{
	import com.paperworld.flash.core.loading.handlers.SoundFileLoadCompleteHandler;
	import com.paperworld.flash.core.space.files.FileDefinition;
	
	import flash.net.URLRequest;

	public class SoundLoadAction extends LoaderAction
	{
		public function SoundLoadAction(file:FileDefinition)
		{
			super(new URLRequest(file.location));
			
			loadCompleteHandler = new SoundFileLoadCompleteHandler();
		}
	}
}