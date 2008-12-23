package  
{
	import org.papervision3d.materials.WireframeMaterial;	
	import org.papervision3d.objects.primitives.Plane;
	
	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.flash.behaviours.SimpleAvatarBehaviour25D;
	import com.paperworld.flash.objects.LocalAvatar;
	import com.paperworld.flash.objects.RemoteAvatar;	

	/**
	 * @author Trevor
	 */
	public class LinkageEnforcer 
	{
		private var client : LocalAvatar;

		private var proxy : RemoteAvatar;

		private var plane : Plane;
		
		private var material : WireframeMaterial;

		private var logger : XrayLog;

		private var behaviour : SimpleAvatarBehaviour25D;
	}
}
