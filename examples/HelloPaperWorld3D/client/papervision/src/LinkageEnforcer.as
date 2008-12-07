package  
{
	import com.paperworld.multiplayer.behaviours.SimpleAvatarBehaviour25D;	
	import com.blitzagency.xray.logger.XrayLog;	

	import org.papervision3d.objects.primitives.Plane;

	import com.paperworld.multiplayer.objects.Client;
	import com.paperworld.multiplayer.objects.Proxy;	

	/**
	 * @author Trevor
	 */
	public class LinkageEnforcer 
	{
		private var client : Client;

		private var proxy : Proxy;

		private var plane : Plane;

		private var logger : XrayLog;

		private var behaviour : SimpleAvatarBehaviour25D;
	}
}
