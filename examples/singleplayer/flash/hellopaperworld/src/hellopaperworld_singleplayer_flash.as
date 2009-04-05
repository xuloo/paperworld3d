package {
	
	import com.paperworld.flash.core.loading.actions.SkinFileLoadAction;
	import com.paperworld.flash.core.world.World;
	
	import flash.display.Sprite;

	public class hellopaperworld_singleplayer_flash extends Sprite
	{
		private var skinFileLoadAction:SkinFileLoadAction;
		
		public function hellopaperworld_singleplayer_flash()
		{
			new World("hellopaperworld");
		}
	}
}
