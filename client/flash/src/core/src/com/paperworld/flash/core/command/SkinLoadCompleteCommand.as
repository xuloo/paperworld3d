package com.paperworld.flash.core.command
{
	import com.paperworld.flash.util.library.ExternalLibraryManager;
	import com.paperworld.flash.util.library.LibraryManager;
	
	import flash.display.Loader;
	
	import org.springextensions.actionscript.mvcs.command.AbstractLoadCompleteCommand;
	
	public class SkinLoadCompleteCommand extends AbstractLoadCompleteCommand
	{
		override public function execute():void 
		{
			var loader:Loader = Loader(loadOperation.result);
			
			(LibraryManager.instance as ExternalLibraryManager).registerSkinFile(loader);
		}
	}
}