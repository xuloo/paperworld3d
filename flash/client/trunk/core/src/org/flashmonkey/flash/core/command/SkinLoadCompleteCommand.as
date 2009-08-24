package org.paperworld.flash.core.command
{
	import org.paperworld.flash.utils.library.ExternalLibraryManager;
	import org.paperworld.flash.utils.library.LibraryManager;
	
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