package  
{
	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.flash.behaviours.SimpleAvatarBehaviour25D;
	import com.paperworld.flash.objects.LocalAvatar;
	import com.paperworld.flash.objects.RemoteAvatar;

	import org.papervision3d.materials.WireframeMaterial;
	import org.papervision3d.materials.utils.MaterialsList;
	import org.papervision3d.objects.primitives.Cube;
	import org.papervision3d.objects.primitives.Plane;		

	/**
	 * @author Trevor
	 */
	public class LinkageEnforcer 
	{
		private var client : LocalAvatar;

		private var proxy : RemoteAvatar;

		private var cube : ColouredCube;

		private var logger : XrayLog;

		private var behaviour : SimpleAvatarBehaviour25D;
	}
}
