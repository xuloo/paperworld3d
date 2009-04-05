package com.paperworld.flash.core.loading.actions
{
	import com.paperworld.flash.core.space.files.FileDefinition;
	import com.paperworld.flash.util.LibraryManager;
	
	import flash.net.URLRequest;

	public class SoundFileLoadAction extends LoaderAction
	{
		public function SoundFileLoadAction(file:FileDefinition)
		{
			super(new URLRequest(file.location));
		}
		
		override protected function onLoadComplete():void 
		{
			LibraryManager.getInstance().registerSoundFile(loader);
		}
	}
}