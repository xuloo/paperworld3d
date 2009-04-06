package com.paperworld.flash.core.loading.actions
{
	import com.paperworld.flash.core.space.files.FileDefinition;
	
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;

	public class LibraryLoadAction extends LoaderAction
	{
		public function LibraryLoadAction(file:FileDefinition)
		{
			super(new URLRequest(file.location));
		}
		
		override protected function load():void 
		{
			if (urlRequest)
			{
				loader.load(urlRequest, new LoaderContext(false, ApplicationDomain.currentDomain));
			}
		}
	}
}