package com.paperworld.flash.core.loading.actions
{
	import com.paperworld.flash.core.loading.interfaces.ILoadableAction;
	import com.paperworld.flash.core.space.files.FileDefinition;
	import com.paperworld.flash.util.LibraryManager;
	
	import flash.net.URLRequest;
	
	public class SkinFileLoadAction extends LoaderAction
	{
		public function SkinFileLoadAction(file:FileDefinition)
		{
			super(new URLRequest(file.location));
		}
		
		override protected function onLoadComplete():void 
		{
			LibraryManager.getInstance().registerSkinFile(loader);
		}
	}
}