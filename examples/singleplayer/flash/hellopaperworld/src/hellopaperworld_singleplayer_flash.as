package {
	
	import com.paperworld.flash.bootstrapper.Bootstrapper;
	
	import flash.display.Sprite;

	public class hellopaperworld_singleplayer_flash extends Sprite
	{		
		public function hellopaperworld_singleplayer_flash()
		{
			Bootstrapper.getInstance(this).load("hellopaperworld");
		}
	}
}
