package com.paperworld
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	
	public class PaperWorld
	{
		private static var $instance:PaperWorld;
		
		private var $stage:DisplayObject;
		
		public function get stage():DisplayObject
		{
			return $stage;
		}
		
		public function PaperWorld()
		{
		}
		
		public static function getInstance():PaperWorld
		{
			if ($instance == null)
			{
				$instance = new PaperWorld();
			}
			
			return $instance;
		}
		
		public function initialise(stage:DisplayObject):void 
		{
			$stage = stage;
		}

	}
}