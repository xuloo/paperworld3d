package com.paperworld.cameras 
{
	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.rpc.objects.Avatar;
	
	import org.papervision3d.cameras.FreeCamera3D;
	import org.papervision3d.core.render.AbstractRenderEngine;
	import org.papervision3d.events.RendererEvent;		

	/**
	 * @author Trevor
	 */
	public class FollowCamera3D extends FreeCamera3D 
	{
		public static const TYPE:String = "FOLLOWCAMERA3D";
		
		private var $target : Avatar;

		private var $renderer : AbstractRenderEngine;
		
		private var logger:XrayLog = new XrayLog();
		
		public function FollowCamera3D(renderer:AbstractRenderEngine = null, zoom : Number = 2, focus : Number = 100, initObject : Object = null)
		{
			super( zoom, focus, initObject );
			
			$renderer = renderer;
		}

		public function set target(value : Avatar) : void 
		{
			$target = value;
		}

		public function set renderer(value : AbstractRenderEngine) : void 
		{
			$renderer = value;
			$renderer.addEventListener( RendererEvent.RENDER_DONE, updateCamera );
		}

		public function updateCamera(event : RendererEvent) : void
		{						
			transform.copy( $target.avatar.current.transform );
			moveBackward( 750 );
			moveUp( -( $target.character.input.mouseY * 30 ) + 270 );
			moveLeft( -( $target.character.input.mouseX * 15 ) );
			//roll( ( $target.character.input.mouseX * 5 ) );	
			pitch( 10 );
		}
	}
}
