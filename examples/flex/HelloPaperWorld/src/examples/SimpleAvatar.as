package examples
{
	import com.paperworld.rpc.objects.Avatar;
	import com.paperworld.rpc.objects.Proxy;
	import com.paperworld.rpc.objects.RemoteObject;
	import com.paperworld.rpc.objects.SimpleBehaviour2D;
	
	import org.papervision3d.materials.ColorMaterial;
	import org.papervision3d.objects.primitives.Plane;

	public class SimpleAvatar extends Avatar
	{
		public function SimpleAvatar()
		{
			super();
		}
		
		override protected function createAvatar(data:Object = null):void
		{
			var material:ColorMaterial = new ColorMaterial(0x00ff00);
			material.doubleSided = true;
			var plane:Plane = new Plane(material, 250, 250);
			
			avatar = new RemoteObject(plane);
			
			addChild(plane);
		}
		
		/*override protected function createBehaviour():void
		{
			behaviour = new SimpleBehaviour2D();
		}*/
		
		override protected function createProxy():void
		{
			var material:ColorMaterial = new ColorMaterial(0xff0000);
			material.doubleSided = true;
			var plane:Plane = new Plane(material, 250, 250);
			
			proxy = new Proxy(plane);
			
			addChild(plane);
		}
	}
}