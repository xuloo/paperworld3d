package com.paperworld.flash.core.loading.handlers
{
	import com.paperworld.flash.core.loading.interfaces.ILoadCompleteHandler;
	import com.paperworld.flash.util.LibraryManager;
	
	import flash.display.Loader;
	
	public class SkinFileLoadCompleteHandler implements ILoadCompleteHandler
	{
		public function handleLoadComplete(data:*):void
		{
			LibraryManager.getInstance().registerSkinFile(Loader(data));
		}
		
	}
}