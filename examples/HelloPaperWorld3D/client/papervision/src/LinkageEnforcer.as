package  
{
	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.flash.behaviours.SimpleAvatarBehaviour25D;
	import com.paperworld.flash.objects.LocalAvatar;
	import com.paperworld.flash.objects.PhysicsEnabledLocalAvatar;
	import com.paperworld.flash.objects.RemoteAvatar;	

	/**
	 * @author Trevor
	 */
	public class LinkageEnforcer 
	{
		private var client : LocalAvatar;		private var physicsClient : PhysicsEnabledLocalAvatar;

		private var proxy : RemoteAvatar;

		private var cube : ColouredCube;

		private var logger : XrayLog;

		private var behaviour : SimpleAvatarBehaviour25D;
	}
}
